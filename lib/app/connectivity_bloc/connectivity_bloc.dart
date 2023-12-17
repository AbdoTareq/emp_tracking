import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(ConnectivityInitial());

  ConnectivityResult? connectivityResult;

  Stream<ConnectivityState> mapEventToState(
    ConnectivityEvent event,
  ) async* {
    try {
      if (event is GetConnectivityEvent) {
        final connectivityResult = await (Connectivity().checkConnectivity());

        if ((this.connectivityResult == null ||
                this.connectivityResult == ConnectivityResult.none) &&
            (connectivityResult == ConnectivityResult.wifi ||
                connectivityResult == ConnectivityResult.mobile)) {
          // Connected
          this.connectivityResult = connectivityResult;
          yield ConnectedState();
        } else if ((this.connectivityResult == null ||
                this.connectivityResult == ConnectivityResult.wifi ||
                this.connectivityResult == ConnectivityResult.mobile) &&
            (connectivityResult == ConnectivityResult.none)) {
          // Not connected
          this.connectivityResult = connectivityResult;
          yield NotConnectedState();
        }
      } else if (event is GetInternetConnectionEvent) {
        yield ConnectingInternetState();
        bool isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
        if (isDeviceConnected) {
          yield ConnectedInternetState();
        } else {
          yield NotConnectedState();
        }
      }
    } catch (e) {
      yield ErrorConnectivityState(message: "error_occurred");

      // Utils.throwExceptionToFirebase(exception: e);
    }
  }
}
