import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locq/class/stationListResponse.dart';
import 'package:locq/redux/app_state.dart';
import 'package:locq/utilities/map_utilities.dart';
import 'package:redux/redux.dart'
;

void showSelectedStationModal(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return StoreConnector<AppState, LatLng>(
          converter: (store) => store.state.googleMapState.currentLocation,
          builder: (context, currentLocation) {
            return StoreConnector<AppState, Map<LatLng, Stations>>(
                converter: (store) =>
                store.state.googleMapState.selectedStationLocation,
                builder: (context, selectedStationLocation) {
                  return WillPopScope(onWillPop: () async {
                    return true;
                  }, child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return FractionallySizedBox(
                        heightFactor: 0.55,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Back to List',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text('Done',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  ListTile(
                                    title: Text(
                                      selectedStationLocation.values.last
                                          .name ?? "",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      selectedStationLocation.values.last
                                          .address ?? "",
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.time_to_leave,
                                        ), Text(
                                          "${metersToKm(distanceInMeters(
                                              currentLocation.latitude,
                                              currentLocation.longitude,
                                              selectedStationLocation.keys
                                                  .last.latitude,
                                              selectedStationLocation.keys
                                                  .last.longitude))
                                              .toStringAsFixed(
                                              2)} Km away",
                                          style: const TextStyle(
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time,
                                        ), Text(
                                          "Opens from ${selectedStationLocation.values.last.opensAt} to ${selectedStationLocation.values.last.closesAt}",
                                          style: const TextStyle(
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
        );
      },
      shape: const CircleBorder());
}
