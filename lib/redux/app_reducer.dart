import 'app_state.dart';
import 'login/login_reducer.dart';
import 'google_map/google_map_reducer.dart';
import 'navigation/navigation_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    navigation: navigationReducer(state.navigation, action),
    loginState: loginReducer(state.loginState, action),
    googleMapState: googleMapReducer(state.googleMapState, action),
  );
}
