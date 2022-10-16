import '../redux/login/login_middleware.dart';
import '../redux/google_map/google_map_middleware.dart';
import '../redux/navigation/navigation_middleware.dart';
import 'package:redux/redux.dart';

import 'app_reducer.dart';
import 'app_state.dart';


Future<Store<AppState>> createStore() async {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      LoginMiddleware(),
      GoogleMapMiddleware(),
      NavigationMiddleware(),
    ],
  );
}
