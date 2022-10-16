import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locq/class/stationListResponse.dart';
import 'package:locq/pages/modals/selected_station_modal.dart';
import 'package:locq/redux/app_state.dart';
import 'package:locq/redux/google_map/google_map_action.dart';
import 'package:locq/utilities/map_utilities.dart';
import 'package:redux/redux.dart';

Widget locationItem(int index, BuildContext context, Stations? stations,
    StateSetter setState) {
  Store<AppState> store = StoreProvider.of<AppState>(context);
  return StoreConnector<AppState, Map<String, dynamic>>(
    converter: (store) => {
      'currentLocation': store.state.googleMapState.currentLocation,
      'mapController': store.state.googleMapState.mapController,
    },
    builder: (context, vm) {
      return ListTile(
        title: Text(
          stations?.name ?? "",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "${metersToKm(distanceInMeters(vm['currentLocation'].latitude ?? 0, vm['currentLocation'].longitude ?? 0, stations?.latitude ?? 0, stations?.longitude ?? 0)).toStringAsFixed(2)} Km away from you",
          style: const TextStyle(fontSize: 10),
        ),
        trailing: const Icon(
          Icons.check_circle_outline,
          color: Colors.grey,
        ),
        onTap: () {
          final Map<LatLng, Stations> selectedStationLocation = {};
          LatLng latLng = LatLng(stations?.latitude ?? 0, stations?.longitude ?? 0);
          selectedStationLocation[latLng] = stations ?? Stations();
          Navigator.pop(context);
          store.dispatch(SetSelectedStationLocation(
              selectedStationLocation,latLng, vm['mapController'], () => {
                showSelectedStationModal(context)
          }));
        },
      );
    },
  );
}
