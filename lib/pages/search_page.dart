import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:locq/class/stationListResponse.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
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
      // body: ,
    );
  }
}
