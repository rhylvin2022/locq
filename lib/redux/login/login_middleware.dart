import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locq/API/login_api.dart';
import 'package:locq/class/successfulLoginResponse.dart';
import 'package:locq/redux/google_map/google_map_action.dart';
import 'package:locq/redux/login/login_action.dart';
import 'package:locq/redux/navigation/navigation_action.dart';
import 'package:redux/redux.dart';
import '../app_state.dart';

//* login redux middleware
class LoginMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoginInAPI) {

      try {
        // check if empty
        if (action.number == '' || action.password == '') {
          // display error message
          // store.dispatch(ShowToastMessage("Some fields are missing"));
        } else {
          // login(action.number, action.password, store, action.context)
          login('+639021234567', '123456', store, action.context)
              .then((value) {
            Map<String, dynamic> map = jsonDecode(value.body);
            var myRootNode = SuccessfulLoginResponse.fromJson(map);
            print('myRootNode.data?.accessToken: ${myRootNode.data?.accessToken}');
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => GoogleMapPage(accessToken: myRootNode.data?.accessToken ?? "")),
            //       (Route<dynamic> route) => false,
            // );
            store.dispatch(GetCurrentLocation());
          });
        }
      } catch (e) {}
    }
    if (action is GetCurrentLocation) {
      LocationPermission permission = await Geolocator.requestPermission();

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      double lat = position.latitude;
      double long = position.longitude;

      //test my Cebu Location
      double cebuLat = 10.253058;
      double cebuLng = 123.803408;

      // _currentPosition = LatLng(lat, long);
      store.dispatch(SetCurrentLocation(LatLng(cebuLat, cebuLng)));
      // _currentPosition = LatLng(cebuLat, cebuLng);
      store.dispatch(SetGoogleMapLoading(false));
      // _isLoading = false;

      store.dispatch(NavigationAction.pushReplaceGoogleMapPage);
    }

    if (action is SetLoginLoading) {}
    next(action);
  }
}
