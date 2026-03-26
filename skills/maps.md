# skills/maps.md — Google Maps Guide (Yug)
> Read CLAUDE.md and AGENTS.md first.

## Your Job
Build map_screen.dart with color-coded POI pins loaded from Firestore. Tap pin → bottom sheet with details.

## pubspec.yaml — add this
```yaml
dependencies:
  google_maps_flutter: ^2.5.0
  geolocator: ^11.0.0
```

## Android Setup
`android/app/src/main/AndroidManifest.xml` — add inside `<application>`:
```xml
<meta-data
  android:name="com.google.android.geo.API_KEY"
  android:value="${MAPS_API_KEY}"/>
```

`android/app/build.gradle` — add in `defaultConfig`:
```gradle
manifestPlaceholders = [MAPS_API_KEY: project.MAPS_API_KEY]
```

`android/local.properties` — add (DO NOT commit this file):
```
MAPS_API_KEY=your_actual_key_here
```

## Pin Colors by Category
```dart
// lib/utils/map_utils.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtils {
  static BitmapDescriptor categoryColor(String category) {
    switch (category) {
      case 'temple':      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
      case 'food':        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      case 'hidden_gem':  return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 'safe_spot':   return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
      case 'kumbh':       return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
      default:            return BitmapDescriptor.defaultMarker;
    }
  }
}
```

## Map Screen
```dart
// lib/screens/map_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/poi_service.dart';
import '../models/poi_model.dart';
import '../utils/map_utils.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  PoiModel? _selectedPoi;

  static const LatLng _nashikCenter = LatLng(19.9975, 73.7898);

  @override
  void initState() {
    super.initState();
    _loadPOIs();
  }

  Future<void> _loadPOIs() async {
    final pois = await PoiService().getPOIs();
    setState(() {
      _markers = pois.map((poi) => Marker(
        markerId: MarkerId(poi.name),
        position: LatLng(poi.lat, poi.lng),
        icon: MapUtils.categoryColor(poi.category),
        onTap: () => setState(() => _selectedPoi = poi),
      )).toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _nashikCenter, zoom: 13),
            markers: _markers,
            myLocationEnabled: true,
            onMapCreated: (c) => _controller = c,
            onTap: (_) => setState(() => _selectedPoi = null),
          ),
          if (_selectedPoi != null)
            Positioned(
              bottom: 16, left: 16, right: 16,
              child: _PoiBottomCard(poi: _selectedPoi!),
            ),
        ],
      ),
    );
  }
}

class _PoiBottomCard extends StatelessWidget {
  final PoiModel poi;
  const _PoiBottomCard({required this.poi});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(poi.name, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(poi.description),
            if (poi.isWomenSafe)
              const Chip(label: Text('✓ Women Safe'), backgroundColor: Color(0xFFE8F5E9)),
          ],
        ),
      ),
    );
  }
}
```

## Hardcoded POI Fallback (use if Firestore not ready)
```dart
// In PoiModel — mockData()
static List<PoiModel> mockData() => [
  PoiModel(name: 'Trimbakeshwar Temple', category: 'temple', lat: 19.9327, lng: 73.5312, description: 'Ancient Shiva temple', isWomenSafe: true),
  PoiModel(name: 'Sula Vineyards', category: 'hidden_gem', lat: 19.9924, lng: 73.8361, description: 'India\'s wine capital', isWomenSafe: true),
  PoiModel(name: 'Pandavleni Caves', category: 'hidden_gem', lat: 19.9620, lng: 73.7720, description: '2000-year-old Buddhist caves', isWomenSafe: false),
  PoiModel(name: 'Panchavati Ghats', category: 'temple', lat: 20.0000, lng: 73.7833, description: 'Sacred Godavari ghats', isWomenSafe: true),
  PoiModel(name: 'Saraf Bazaar', category: 'food', lat: 19.9990, lng: 73.7900, description: 'Best street food in Nashik', isWomenSafe: true),
];
```
