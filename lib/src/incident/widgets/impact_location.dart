import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ImpactLocation extends StatefulWidget {
  const ImpactLocation({super.key});

  @override
  State<ImpactLocation> createState() => _ImpactLocationState();
}

class _ImpactLocationState extends State<ImpactLocation> {
  late GoogleMapController mapController;

  //final LatLng _center = const LatLng(45.521563, -122.677433);

  static const LatLng _pGooglePlex = LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Example'),
        backgroundColor: Colors.white,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _pGooglePlex,
          zoom: 13,
        ),
      ),
    );
  }
}
