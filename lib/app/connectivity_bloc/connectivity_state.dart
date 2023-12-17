part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityState {
  ConnectivityState();
}

class ConnectivityInitial extends ConnectivityState {}

class ConnectedState extends ConnectivityState {
  ConnectedState();
}

class ConnectedInternetState extends ConnectivityState {
  ConnectedInternetState();
}
class ConnectingInternetState extends ConnectivityState
{
  ConnectingInternetState();
}

class WifiConnectedState extends ConnectivityState {
  WifiConnectedState();
}

class MobileConnectedState extends ConnectivityState {
  MobileConnectedState();
}

class NotConnectedState extends ConnectivityState {
  NotConnectedState();
}

class ErrorConnectivityState extends ConnectivityState {
  final String? message;

  ErrorConnectivityState({this.message});
}
