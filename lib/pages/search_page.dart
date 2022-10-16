import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:locq/components/location_item.dart';
import 'package:locq/redux/app_state.dart';
import 'package:locq/redux/google_map/google_map_action.dart';
import '../class/stationListResponse.dart';
import 'package:redux/redux.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Store store = StoreProvider.of<AppState>(context);
    return StoreConnector<AppState, Map<String, dynamic>>(
      converter: (store) => {
        'searchedStations': store.state.googleMapState.searchedStations,
        'mapController': store.state.googleMapState.mapController,
        // 'currentLocation': store.state.googleMapState.currentLocation,
        // 'markers': store.state.googleMapState.markers,
        // 'stationDataFetchingLoading': store.state.googleMapState.stationDataFetchingLoading,
      },
      builder: (context, vm) {
        String search = '';
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(165),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: const Center(child: Text('Search Station')),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        icon: const Icon(Icons.close))
                  ],
                  bottom: PreferredSize(
                      child: Column(
                        children: [
                          const Text(
                            "Which PriceLOCQ station will you likely visit",
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              color: Colors.white,
                              child: TextField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Search',
                                  hintText: 'Enter Location',
                                ),
                                onChanged: (text) {
                                  search = text;
                                  store.dispatch(SearchFromList(search));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      preferredSize: const Size.fromHeight(20)),
                ),
              ),
              body: ListView.builder(
                  itemCount: vm['searchedStations'].length,
                  itemBuilder: (context, index) {
                    return locationItem(
                        index,
                        context,
                        vm['searchedStations'][index],
                        setState);
                  }),
            );
          },
        );
      },
    );
  }
}