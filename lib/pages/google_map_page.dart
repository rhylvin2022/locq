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
import 'search_page.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {

  late GoogleMapController mapController;
  late Store<AppState> store;

  @override
  void initState() {
    super.initState();
    // fetchStationLocations();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
        print('currentLocation: ${vm['currentLocation']}');
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Center(child: Text('Search Station')),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
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
            onPressed: fetchStationLocations,
            tooltip: 'Fetch Location',
            child: const Icon(Icons.my_location),
          ), // This trailing
        );
      },
    );
  }

  void fetchStationLocations() {
    if (/*sortedStations.isNotEmpty*/ store
        .state.googleMapState.sortedStations.isNotEmpty) {
      showStationList();
    } else {
      store.dispatch(SetStationDataFetchingLoading(true));
      store.dispatch(GetStationDataAPI(showStationList));
    }
  }

  void showStationList() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StoreConnector<AppState, Map<String, dynamic>>(
              converter: (store) => {
                    'sortedStations': store.state.googleMapState.sortedStations,
                  },
              builder: (context, vm) {
                return WillPopScope(onWillPop: () async {
                  return true;
                }, child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return FractionallySizedBox(
                      heightFactor: 0.55,
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Nearby Stations',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text('Done',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  // itemCount: sortedStations.length,
                                  itemCount: vm['sortedStations'].length,
                                  itemBuilder: (context, index) {
                                    return locationItem(index,
                                        vm['sortedStations'][index], setState);
                                  }),
                            )
                          ],
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                      ),
                    );
                  },
                ));
              });
        },
        shape: const CircleBorder());
  }

  Widget locationItem(int index, Stations? stations, StateSetter setState) {
    return StoreConnector<AppState, Map<String, dynamic>>(
      converter: (store) => {
        'currentLocation': store.state.googleMapState.currentLocation,
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
            store.dispatch(SetSelectedStationsLocation(
                LatLng(stations?.latitude ?? 0, stations?.longitude ?? 0),
                mapController));
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
