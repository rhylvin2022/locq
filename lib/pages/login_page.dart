import 'package:flutter/material.dart';
import 'package:locq/redux/app_state.dart';
import 'package:locq/redux/login/login_action.dart';
import 'dart:convert';
import 'google_map_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, color: Colors.white));

  @override
  Widget build(BuildContext context) {
    String number = '';
    String password = '';
    // bool loginLoading = false;

    Store store = StoreProvider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOCQ, OPC Test'),
      ),
      body: StoreConnector<AppState, Map<String, dynamic>>(
        converter: (store) => {
          "loginLoading": store.state.loginState.loginLoading,
        },
        builder: (context, vm) {
          return Center(
            child: vm["loginLoading"]
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Number',
                            hintText: 'Enter Your Mobile Number',
                          ),
                          onChanged: (text) {
                            number = text;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter Your Password',
                          ),
                          onChanged: (text) {
                            password = text;
                          },
                        ),
                      ),
                      ElevatedButton(
                        style: style,
                        child: const Text('Sign In'),
                        onPressed: () {
                          store.dispatch(SetLoginLoading(true));
                          store.dispatch(LoginInAPI(
                              number: number,
                              password: password,
                              context: context));
                        },
                      )
                    ],
                  ),
          );
        },
      ),
    );
  }
}
