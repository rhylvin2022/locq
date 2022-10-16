import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locq/class/stationListResponse.dart';
import 'package:redux/redux.dart';

import '../app_state.dart';

class GetStationListAPI {
  final String accessToken;
  final BuildContext context;

  GetStationListAPI({
    required this.accessToken,
    required this.context,
  });
}

class SetCurrentLocation {
  final LatLng currentLocation;
  SetCurrentLocation(this.currentLocation);
}

class SetGoogleMapLoading {
  final bool googleMapLoading;
  SetGoogleMapLoading(this.googleMapLoading);
}

class SetMarkers {
  final Map<MarkerId, Marker> marker;
  SetMarkers(this.marker);
}

class SetStationDataFetchingLoading {
  final bool stationDataFetchingLoading;
  SetStationDataFetchingLoading(this.stationDataFetchingLoading);
}

class SetSortedStations {
  final List<Stations> sortedStations;
  SetSortedStations(this.sortedStations);
}

class SetSelectedStationsLocation {
  final LatLng selectedStationLocation;
  final GoogleMapController mapController;
  SetSelectedStationsLocation(this.selectedStationLocation, this.mapController);
}

typedef VoidCallback = void Function();
class GetStationDataAPI{
  final VoidCallback callback;
  GetStationDataAPI(this.callback);
}