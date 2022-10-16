import 'package:redux/redux.dart';

import 'login_action.dart';
import 'login_state.dart';

final loginReducer = combineReducers<LoginState>([
  TypedReducer<LoginState, LoginInAPI>(
      _authenticateReducers),
  TypedReducer<LoginState, SetLoginLoading>(
      _setLoginLoading),
]);

LoginState _authenticateReducers(
    LoginState state, LoginInAPI action) {
  return state.copyWith();
}
LoginState _setLoginLoading(
    LoginState state, SetLoginLoading action) {
  return state.copyWith(loginLoading: action.loginLoading);
}