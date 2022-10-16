import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locq/redux/app_state.dart';

import '../../components/location_item.dart';

void showStationListModal(
    BuildContext context, GoogleMapController mapController) {
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  return locationItem(
                                      index,
                                      context,
                                      vm['sortedStations'][index],
                                      setState,
                                      mapController);
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
