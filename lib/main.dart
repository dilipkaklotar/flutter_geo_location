import 'package:flutter/material.dart';
import 'package:geo_location_finder/geo_location_finder.dart';

import 'dart:async';
import 'package:flutter/services.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Location Example',
      theme: ThemeData.light(),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _result = 'Unknown';

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    Map<dynamic, dynamic> locationMap;

    String result;

    try {
      locationMap = await GeoLocation.getLocation;
      var status = locationMap["status"];
      if ((status is String && status == "true") ||
          (status is bool) && status) {
        var lat = locationMap["latitude"];
        var lng = locationMap["longitude"];

        if (lat is String) {
          result = "Location: ($lat, $lng)";
        } else {
          // lat and lng are not string, you need to check the data type and use accordingly.
          // it might possible that else will be called in Android as we are getting double from it.
          result = "Location: ($lat, $lng)";
        }
      } else {
        result = locationMap["message"];
      }
    } on PlatformException {
      result = 'Failed to get location';
    }

    if (!mounted) return;

    setState(() {
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Location Example'),
        ),
        body: Center(
          child: Text('$_result'),
        ),
      ),
    );
  }
}
