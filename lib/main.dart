import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locq/pages/google_map_page.dart';
import 'package:locq/pages/search_page.dart';
import 'package:page_transition/page_transition.dart';
import '../redux/navigation/navigation_middleware.dart';
import '../redux/app_state.dart';
import '../pages/login_page.dart';
import '../redux/store.dart';

import 'package:redux/redux.dart';

void main() async {
  final store = await createStore();
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  const MyApp({Key? key, required this.store}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LOCQ, OPC Test',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        // home: const LoginPage(title: 'LOCQ, OPC Test'),
        navigatorKey: navigatorKey,
        onGenerateRoute: (RouteSettings settings) => _getRoute(settings),
      ),
    );
  }

  PageTransition _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return PageTransition(
          child: LoginPage(),
          type: PageTransitionType.fade,
        );
      case '/login':
        return PageTransition(
          child: LoginPage(),
          type: PageTransitionType.fade,
        );
      case '/googleMap':
        return PageTransition(
          child: const GoogleMapPage(),
          type: PageTransitionType.fade,
        );
      case '/search':
        return PageTransition(
          child: const SearchPage(),
          type: PageTransitionType.fade,
        );
      default:
        return PageTransition(
          child: LoginPage(),
          type: PageTransitionType.fade,
        );
    }
  }
}

