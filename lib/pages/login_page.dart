import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locq/class/successfulLoginResponse.dart';
import '../class/successfulLoginResponse.dart';
import 'google_map_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  String number = "";
  String password = "";

  // textColor: Colors.white,
  // color: Colors.blue,
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, color: Colors.white));

  bool loginLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: loginLoading ? const CircularProgressIndicator() : Column(
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
                setState(() {
                  loginLoading = true;
                });
                login().then((value) {
                  Map<String, dynamic> map = jsonDecode(value.body);
                  var myRootNode = SuccessfulLoginResponse.fromJson(map);
                  print(myRootNode.data?.accessToken);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => GoogleMapPage(accessToken: myRootNode.data?.accessToken ?? "")),
                        (Route<dynamic> route) => false,
                  );
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Future<http.Response> login() {
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
}