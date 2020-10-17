import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapaGoogleComponent extends StatefulWidget {
  @override
  _MapaGoogleComponentState createState() => _MapaGoogleComponentState();
}

class _MapaGoogleComponentState extends State<MapaGoogleComponent> {
  GoogleMapController _controller;
  Location location = new Location();
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  bool _serviceEnabled;
  bool isLoading = false;

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
        child: GoogleMap(
      initialCameraPosition:
          CameraPosition(target: LatLng(lat, long), zoom: 13.0),
      mapType: MapType.normal,
      onMapCreated: (controller) {
        _controller = controller;
      },
      onTap: (cordinate) {
        _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
      },
    ));
  }
}
