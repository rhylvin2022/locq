import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../app_state.dart';

class LoginInAPI {
  final String number;
  final String password;
  final BuildContext context;

  LoginInAPI({
    required this.number,
    required this.password,
    required this.context,
  });
}

class SetLoginLoading {
  final bool loginLoading;
  SetLoginLoading(this.loginLoading);
}

class GetCurrentLocation {}