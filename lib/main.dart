
import 'package:flutter/material.dart';
import 'package:locq/pages/login_page.dart';

import 'package:redux/redux.dart';

void main() {
  // final store
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOCQ, OPC Test',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const LoginPage(title: 'LOCQ, OPC Test'),
    );
  }
}

