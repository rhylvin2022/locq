
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locq/API/google_map_api.dart';
import 'package:locq/class/stationListResponse.dart';
import 'package:locq/utilities/map_utilities.dart';

import '../google_map/google_map_action.dart';
import 'package:redux/redux.dart';
import '../app_state.dart';

class GoogleMapMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is GetStationListAPI) {
    }
    if (action is SetCurrentLocation) {

      var marker = Marker(
        markerId: const MarkerId('you'),
        position: action.currentLocation,
        // icon: BitmapDescriptor.,
        infoWindow: const InfoWindow(
          title: 'Your Location',
        ),
      );
      var markers = store.state.googleMapState.markers;
      markers[const MarkerId('you')] = marker;

      store.dispatch(SetMarkers(markers));
    }
    if (action is GetStationDataAPI) {
      getStationListAPI(store.state.googleMapState.accessToken).then((value) {
        Map<double, Stations> stations = {};
        List<Stations> sortedStations = [];
        store.dispatch(SetStationDataFetchingLoading(false));
        Map<String, dynamic> map = jsonDecode(value.body);
        StationListResponse.fromJson(map)
            .data
            ?.stations
            ?.forEach((element) async {
              print('store.state.googleMapState.currentLocation.latitude: ${store.state.googleMapState.currentLocation.latitude}');
          stations[distanceInMeters(
              store.state.googleMapState.currentLocation.latitude,
              store.state.googleMapState.currentLocation.longitude,
              element.latitude ?? 0,
              element.longitude ?? 0)] = element;
        });
        stations.keys.toList()
          ..sort()
          ..forEach((element) {
            print('key: $element');
            print(stations[element]?.name.toString());
            print(stations[element]?.longitude);
            print(stations[element]?.latitude);
            sortedStations.add(stations[element] ?? Stations());
            store.dispatch(SetSortedStations(sortedStations));
          });

        //showStationList
        action.callback();
      });
    }
    if (action is SetSelectedStationLocation) {
      var marker = Marker(
        markerId: const MarkerId('station'),
        position: action.stationLocation,
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(
          title: action.selectedStationLocation[action.stationLocation]?.name,
        ),
      );
      var markers = store.state.googleMapState.markers;
      markers[const MarkerId('station')] = marker;

      store.dispatch(SetMarkers(markers));
      updateCameraLocation(store.state.googleMapState.currentLocation,
          action.stationLocation, action.mapController);

      action.callback();
    }
    next(action);
  }
}
