part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityEvent {

  ConnectivityEvent();
}
class GetInternetConnectionEvent extends ConnectivityEvent
{
  GetInternetConnectionEvent();
}

class GetConnectivityEvent extends ConnectivityEvent {

  GetConnectivityEvent();
}
