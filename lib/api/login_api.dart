import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../class/successfulLoginResponse.dart';
import '../redux/app_state.dart';
import '../class/successfulLoginResponse.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

Future<http.Response> login(String number, String password,
    Store<AppState> store, BuildContext context) {
  return http.post(
    Uri.parse('https://staging.api.locq.com/ms-profile/user/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      // "mobileNumber": number,
      // "password": password,
      "mobileNumber": '+639021234567',
      "password": '123456',
      "profileType": "plc"
    }),
  );
}
