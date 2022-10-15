import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../app_state.dart';

class AuthenticateWithNumberAndPassword {
  final String number;
  final String password;
  final BuildContext context;

  AuthenticateWithNumberAndPassword({
    required this.number,
    required this.password,
    required this.context,
  });
}

class GetCredentialsFromPrefs {}

class SetCredentialsFromPrefs {
  final String number;
  final String password;
  SetCredentialsFromPrefs({
    required this.number,
    required this.password,
  });
}

class SaveCredentialsToPrefs {
  final String number;
  final String password;
  SaveCredentialsToPrefs({
    required this.number,
    required this.password,
  });
}

class Logout {
  final BuildContext context;
  Logout(this.context);
}

class GetErrorMessageAction {
  final String error;
  final BuildContext context;
  GetErrorMessageAction(this.error, this.context);
}
