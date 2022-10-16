import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redux/redux.dart';

import 'google_map_action.dart';
import 'google_map_state.dart';

final googleMapReducer = combineReducers<GoogleMapState>([
  TypedReducer<GoogleMapState, GetStationListAPI>(
      _getStationListAPIReducers),
  TypedReducer<GoogleMapState, SetGoogleMapLoading>(
      _setMapLoadingReducer),
  TypedReducer<GoogleMapState, SetMarkers>(
      _setMarkers),
  TypedReducer<GoogleMapState, SetStationDataFetchingLoading>(
      _setStationDataFetchingLoading),
  TypedReducer<GoogleMapState, SetSortedStations>(
      _setSortedStations),
  TypedReducer<GoogleMapState, SetSelectedStationLocation>(
      _setSelectedStationLocation),
  TypedReducer<GoogleMapState, SetCurrentLocation>(
      _setCurrentLocation),
]);

GoogleMapState _getStationListAPIReducers(
    GoogleMapState state, GetStationListAPI action) {
      () async {}();
  return state.copyWith();
}

GoogleMapState _setMapLoadingReducer(GoogleMapState state, SetGoogleMapLoading action) {
  return state.copyWith(googleMapLoading: action.googleMapLoading);
}

GoogleMapState _setMarkers(GoogleMapState state, SetMarkers action) {
  return state.copyWith(markers: action.marker);
}

GoogleMapState _setStationDataFetchingLoading(GoogleMapState state, SetStationDataFetchingLoading action) {
  return state.copyWith(stationDataFetchingLoading: action.stationDataFetchingLoading);
}

GoogleMapState _setSortedStations(GoogleMapState state, SetSortedStations action) {
  return state.copyWith(sortedStations: action.sortedStations);
}

GoogleMapState _setCurrentLocation(GoogleMapState state, SetCurrentLocation action) {
  return state.copyWith(currentLocation: action.currentLocation);
}
GoogleMapState _setSelectedStationLocation(GoogleMapState state, SetSelectedStationLocation action) {
  return state.copyWith(selectedStationLocation: action.selectedStationLocation);
}