import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:locq/class/stationListResponse.dart';
import 'package:locq/redux/google_map/google_map_action.dart';
import 'package:locq/utilities/map_utilities.dart';
import 'package:redux/redux.dart';

import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locq/redux/app_state.dart';
import 'modals/station_list_modal.dart';
import 'search_page.dart';

class GoogleMapPage extends StatelessWidget {
  GoogleMapPage({Key? key}) : super(key: key);

  late Store<AppState> store;


  void _onMapCreated(GoogleMapController controller) {
    store.dispatch(SetGoogleMapController(controller));
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);
    return StoreConnector<AppState, Map<String, dynamic>>(
      converter: (store) => {
        'googleMapLoading': store.state.googleMapState.googleMapLoading,
        'currentLocation': store.state.googleMapState.currentLocation,
        'markers': store.state.googleMapState.markers,
        'stationDataFetchingLoading': store.state.googleMapState.stationDataFetchingLoading,
      },
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Center(child: Text('Search Station')),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SearchPage()),
                    );
                  },
                  icon: const Icon(Icons.search))
            ],
            bottom: const PreferredSize(
                child: Text(
                  "Which PriceLOCQ station will you likely visit",
                  style: TextStyle(color: Colors.white),
                ),
                preferredSize: Size.fromHeight(20)),
          ),
          body: vm['googleMapLoading']
              ? const Center(child: CircularProgressIndicator())
              : Stack(
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: vm['currentLocation'] ?? const LatLng(0, 0),
                  zoom: 16.0,
                ),
                markers: vm['markers'].values.toSet(),
              ),
              vm['stationDataFetchingLoading']
                  ? const Center(child: CircularProgressIndicator())
                  : Container()
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              fetchStationLocations(context);
            },
            tooltip: 'Fetch Location',
            child: const Icon(Icons.my_location),
          ), // This trailing
        );
      },
    );
  }

  void fetchStationLocations(BuildContext context) {
    if (/*sortedStations.isNotEmpty*/ store
        .state.googleMapState.sortedStations.isNotEmpty) {
      showStationListModal(context);
    } else {
      store.dispatch(SetStationDataFetchingLoading(true));
      store.dispatch(GetStationDataAPI(() => {showStationListModal(context)}));
    }
  }
}
