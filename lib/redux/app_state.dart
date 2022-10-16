import 'package:flutter/material.dart';
import '../redux/navigation/navigation_state.dart';
import 'login/login_state.dart';
import 'google_map/google_map_state.dart';

@immutable
class AppState {
  final NavigationState navigation;
  final LoginState loginState;
  final GoogleMapState googleMapState;

  const AppState({
    required this.navigation,
    required this.loginState,
    required this.googleMapState,
  });

  factory AppState.initial() {
    return AppState(
      navigation: NavigationState.initial(),
      loginState: LoginState.initial(),
      googleMapState: GoogleMapState.initial(),
    );
  }

  AppState copyWith({
    NavigationState? navigation,
    LoginState? loginState,
    GoogleMapState? googleMapState,
  }) =>
      AppState(
        navigation: navigation ?? this.navigation,
        loginState: loginState ?? this.loginState,
        googleMapState: googleMapState ?? this.googleMapState,
      );
}
