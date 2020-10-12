import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:location/location.dart';

class MapComponent extends StatefulWidget {
  @override
  _MapComponentState createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  MapboxMapController mapController;
  Location location = new Location();
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  bool _serviceEnabled;
  bool isLoading = false;
  String ACCESS_TOKEN =
      "pk.eyJ1Ijoiam92YW5ueXJjaCIsImEiOiJjazRmdWJqYjQwamZ1M2xwMjE0ZWVlZGxiIn0.Go6ff35VFrdev8hmTFK5Ow";

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    setState(() {
      isLoading = true;
    });
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    final lat = _locationData.latitude ?? 0.0;
    final long = _locationData.longitude ?? 0.0;

    return Container(
      child: MapboxMap(
        accessToken: ACCESS_TOKEN,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, long),
          zoom: 13,
        ),
      ),
    );
  }
}
