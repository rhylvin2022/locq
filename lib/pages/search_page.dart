import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:locq/components/location_item.dart';
import 'package:locq/redux/app_state.dart';
import '../class/stationListResponse.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(
      converter: (store) => {
        'sortedStations': store.state.googleMapState.sortedStations,
        'mapController': store.state.googleMapState.mapController,
        // 'currentLocation': store.state.googleMapState.currentLocation,
        // 'markers': store.state.googleMapState.markers,
        // 'stationDataFetchingLoading': store.state.googleMapState.stationDataFetchingLoading,
      },
      builder: (context, vm) {
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
                                  // icon: Icon(Icons.search),
                                  labelText: 'Search',
                                  hintText: 'Enter Location',
                                ),
                                onChanged: (text) {
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      preferredSize: const Size.fromHeight(20)),
                ),
              ),
              body: Expanded(
                child: ListView.builder(
                  // itemCount: sortedStations.length,
                    itemCount: vm['sortedStations'].length,
                    itemBuilder: (context, index) {
                      return locationItem(
                          index,
                          context,
                          vm['sortedStations'][index],
                          setState);
                    }),
              ),
            );
          },
        );
      },
    );
  }
}