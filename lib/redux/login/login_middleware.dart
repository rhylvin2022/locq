
import 'package:locq/redux/login/login_action.dart';
import 'package:redux/redux.dart';
import '../app_state.dart';

//* login redux middleware
class LoginMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is AuthenticateWithNumberAndPassword) {
      // validate email
      try {
        // check if empty
        if (action.number == '' || action.password == '') {
          // display error message
          // store.dispatch(ShowToastMessage("Some fields are missing"));
        } else {
          // authenticate to firebase
          await signInWithEmailPassword(
            action.number,
            action.password,
            store,
            action.context,
          ).then((result) {
            print('---------------- auth');
            if (result != "") {
              // set loader to false
              // store.dispatch(SetLoader(isLoading: false));
              // result is uid of user
              final userId = result.toString();
              // print("USER: $userId");
              // save to prefs
              store.dispatch(SaveCredentialsToPrefs(
                number: action.number,
                password: action.password,
              ));
              // navigate to home
              // store.dispatch(NavigationAction.pushHome);
            }
          });
        }
      } catch (e) {
        // print("AUTH ERROR: $e");
        // store.dispatch(ShowToastMessage("Invalid email"));
      }
    }
    next(action);
  }
}
