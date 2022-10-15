import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:locq/class/stationListResponse.dart';
import 'search_page.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({required this.accessToken});

  final String accessToken;

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  LatLng? _currentPosition;
  LatLng? selectedStationsLocation;
  bool _isLoading = true;
  bool _isFetchLoading = false;
  Map<double, Stations> stations = {};
  List<Stations> sortedStations = [];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double lat = position.latitude;
    double long = position.longitude;

    //test my Cebu Location
    double cebuLat = 10.253058;
    double cebuLng = 123.803408;
    setState(() {
      // _currentPosition = LatLng(lat, long);
      _currentPosition = LatLng(cebuLat, cebuLng);
      _isLoading = false;

      // markers.add(Marker(
      //   markerId: const MarkerId("you"),
      //   position: _currentPosition ?? const LatLng(0, 0),
      // ));
      var marker = Marker(
        markerId: const MarkerId('you'),
        position: _currentPosition ?? const LatLng(0, 0),
        // icon: BitmapDescriptor.,
        infoWindow: const InfoWindow(
          title: 'Your Location',
        ),
      );
      markers[const MarkerId('you')] = marker;

      fetchLocations();
    });
  }

  Future<http.Response> getStationListAPI() {
    return http.get(
      Uri.parse(
          'https://staging.api.locq.com/ms-fleet/station?page=1&perPage=1000'),
      headers: <String, String>{
        'Authorization': widget.accessToken,
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition ?? const LatLng(0, 0),
                    zoom: 16.0,
                  ),
                  markers: markers.values.toSet(),
                ),
                _isFetchLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container()
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchLocations,
        tooltip: 'Fetch Location',
        child: const Icon(Icons.my_location),
      ), // This trailing
    );
  }

  double distanceInMeters(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  double metersToKm(double meters) {
    return meters / 1000;
  }

  void fetchLocations() {
    if (sortedStations.isNotEmpty) {
      showStationList();
    } else {
      setState(() {
        _isFetchLoading = true;
      });
      getStationListAPI().then((value) {
        setState(() {
          _isFetchLoading = false;
        });
        Map<String, dynamic> map = jsonDecode(value.body);
        StationListResponse.fromJson(map)
            .data
            ?.stations
            ?.forEach((element) async {
          stations[distanceInMeters(
              _currentPosition?.latitude ?? 0,
              _currentPosition?.longitude ?? 0,
              element.latitude ?? 0,
              element.longitude ?? 0)] = element;
        });
        print('stations lenght: ${stations.length}');
        stations.keys.toList()
          ..sort()
          ..forEach((element) {
            print('key: $element');
            print(stations[element]?.name.toString());
            print(stations[element]?.longitude);
            print(stations[element]?.latitude);
            sortedStations.add(stations[element] ?? Stations());
          });

        showStationList();
      });
    }
  }

  void showStationList() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
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
                          children: [
                            const Padding(
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
                              padding: const EdgeInsets.only(right: 10),
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
                            itemCount: sortedStations.length,
                            itemBuilder: (context, index) {
                              return locationItem(
                                  index, sortedStations[index], setState);
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
        },
        shape: const CircleBorder());
  }

  Widget locationItem(int index, Stations? stations, StateSetter setState) {
    return ListTile(
      title: Text(
        stations?.name ?? "",
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "${metersToKm(distanceInMeters(_currentPosition?.latitude ?? 0, _currentPosition?.longitude ?? 0, stations?.latitude ?? 0, stations?.longitude ?? 0)).toStringAsFixed(2)} Km away from you",
        style: const TextStyle(fontSize: 10),
      ),
      trailing: const Icon(
        Icons.check_circle_outline,
        color: Colors.grey,
      ),
      onTap: () {
        setState(() {
          selectedStationsLocation =
              LatLng(stations?.latitude ?? 0, stations?.longitude ?? 0);
          var marker = Marker(
            markerId: const MarkerId('station'),
            position: selectedStationsLocation ?? const LatLng(0, 0),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: const InfoWindow(
              title: 'Station',
            ),
          );
          markers[const MarkerId('station')] = marker;
        });
        // mapController.animateCamera(CameraUpdate.newCameraPosition(
        //     CameraPosition(
        //         target: selectedStationsLocation ?? const LatLng(0, 0),
        //         zoom: 16.4746)));

        updateCameraLocation(_currentPosition ?? const LatLng(0, 0),
            selectedStationsLocation ?? const LatLng(0, 0), mapController);

        Navigator.pop(context);
      },
    );
  }

  Future<void> updateCameraLocation(
    LatLng source,
    LatLng destination,
    GoogleMapController mapController,
  ) async {
    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(source.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, source.longitude));
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, source.longitude),
          northeast: LatLng(source.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 70);

    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate, GoogleMapController mapController) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }
}
