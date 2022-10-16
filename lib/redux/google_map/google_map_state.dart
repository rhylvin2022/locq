import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locq/class/stationListResponse.dart';

class GoogleMapState {
  String accessToken;
  Map<MarkerId, Marker> markers;
  LatLng currentLocation;
  Map<LatLng, Stations> selectedStationLocation;
  bool googleMapLoading;
  bool stationDataFetchingLoading;
  List<Stations> sortedStations;

  GoogleMapState({
    required this.accessToken,
    required this.markers,
    required this.currentLocation,
    required this.selectedStationLocation,
    required this.googleMapLoading,
    required this.stationDataFetchingLoading,
    required this.sortedStations,
  });

  factory GoogleMapState.initial() {
    return GoogleMapState(
      accessToken: "",
      markers: {},
      currentLocation: const LatLng(0,0),
      selectedStationLocation: {},
      googleMapLoading: false,
      stationDataFetchingLoading: false,
      sortedStations: [],
    );
  }

  GoogleMapState copyWith({
    String? accessToken,
    Map<MarkerId, Marker>? markers,
    LatLng? currentLocation,
    Map<LatLng, Stations>? selectedStationLocation,
    bool? googleMapLoading,
    bool? stationDataFetchingLoading,
    List<Stations>? sortedStations,

  }) {
    return GoogleMapState(
      accessToken: accessToken ?? this.accessToken,
      markers: markers ?? this.markers,
      currentLocation: currentLocation ?? this.currentLocation,
      selectedStationLocation: selectedStationLocation ?? this.selectedStationLocation,
      googleMapLoading: googleMapLoading ?? this.googleMapLoading,
      stationDataFetchingLoading: stationDataFetchingLoading ?? this.stationDataFetchingLoading,
      sortedStations: sortedStations ?? this.sortedStations,
    );
  }
}
