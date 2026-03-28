import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<dynamic> _allPlaces = [];
  final Set<String> _selectedCategories = {'Pilgrimage', 'Nature', 'Food', 'Adventure'};
  final List<String> _categories = ['Pilgrimage', 'Nature', 'Food', 'Adventure'];
  @override
  void initState() {
    super.initState();
    _loadPlaces();
  }

  Future<void> _loadPlaces() async {
    try {
      final String response = await rootBundle.loadString('assets/data/places.json');
      final data = await json.decode(response);
      setState(() {
        _allPlaces = data;
      });
    } catch (e) {
      debugPrint("Error loading places.json: $e");
    }
  }

  void _showBottomSheet(dynamic place) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  place['photoUrl'] ?? 'https://via.placeholder.com/400x300',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                place['name'] ?? 'Unknown',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  place['category'] ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                place['description'] ?? 'No description available.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Set<Marker> _buildMarkers() {
    Set<Marker> markers = {};
    for (var place in _allPlaces) {
      if (_selectedCategories.contains(place['category'])) {
        markers.add(
          Marker(
            markerId: MarkerId(place['name']),
            position: LatLng(place['lat'], place['lng']),
            onTap: () => _showBottomSheet(place),
            infoWindow: InfoWindow(title: place['name']),
          ),
        );
      }
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nashik Tourism Map'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: _categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: FilterChip(
                    label: Text(category),
                    selected: _selectedCategories.contains(category),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedCategories.add(category);
                        } else {
                          _selectedCategories.remove(category);
                        }
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: _allPlaces.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(20.0059, 73.7940), // Center of Nashik roughly
                      zoom: 11,
                    ),
                    markers: _buildMarkers(),
                    zoomControlsEnabled: true,
                  ),
          ),
        ],
      ),
    );
  }
}
