import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  
  final LatLng _center = const LatLng(19.9975, 73.7898); // Nashik center

  @override
  void initState() {
    super.initState();
    _loadSavedPlaces();
  }

  Future<void> _loadSavedPlaces() async {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('center'),
          position: _center,
          infoWindow: const InfoWindow(title: 'Nashik Center'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        )
      );
      
      _markers.add(
        const Marker(
          markerId: MarkerId('sula'),
          position: LatLng(20.0055, 73.7412),
          infoWindow: InfoWindow(title: 'Sula Vineyards', snippet: 'Top Attraction'),
        )
      );

      _markers.add(
        const Marker(
          markerId: MarkerId('trimbak'),
          position: LatLng(19.9325, 73.5300),
          infoWindow: InfoWindow(title: 'Trimbakeshwar Temple', snippet: 'Saved Place'),
        )
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map & Saved Places'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers,
      ),
    );
  }
}
