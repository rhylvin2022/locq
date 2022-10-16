import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import '../app_state.dart';

import 'navigation_action.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//* navigation redux middleware
class NavigationMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is NavigationAction) {
      switch (action) {
        case NavigationAction.popLoginPage:
          navigatorKey.currentState!.popUntil(
            ModalRoute.withName('/login'),
          );
          break;
        case NavigationAction.pushReplaceGoogleMapPage:
          navigatorKey.currentState!.pushReplacementNamed("/googleMap");
          break;
        case NavigationAction.pushSearchPage:
          navigatorKey.currentState!.pushNamed("/search");
          break;
        default:
      }
    }
    next(action);
  }
}
