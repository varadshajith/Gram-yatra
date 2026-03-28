import 'dart:convert';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
=======
import 'package:flutter/services.dart' show rootBundle;
>>>>>>> 4a346b892c20e97bdcde7515fb32eabfd9275833
import 'package:google_maps_flutter/google_maps_flutter.dart';

<<<<<<< HEAD
=======
/// Screen: Map & Explore — color-coded POI pins loaded from places.json
/// Yug's scope: map_screen.dart, POI data, Google Maps integration
>>>>>>> 4a346b892c20e97bdcde7515fb32eabfd9275833
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
<<<<<<< HEAD
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
=======
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};
  List<Map<String, dynamic>> _places = [];
  String _selectedCategory = 'All';
  bool _loading = true;

  final LatLng _center = const LatLng(19.9975, 73.7898); // Nashik center

  final AudioGuideService _audioGuide = AudioGuideService();

  // Category filter options
  final List<Map<String, dynamic>> _categories = [
    {'label': 'All', 'icon': Icons.explore, 'hue': BitmapDescriptor.hueAzure},
    {'label': 'pilgrimage', 'icon': Icons.account_balance, 'hue': BitmapDescriptor.hueRose},
    {'label': 'nature', 'icon': Icons.park, 'hue': BitmapDescriptor.hueGreen},
    {'label': 'food', 'icon': Icons.restaurant, 'hue': BitmapDescriptor.hueOrange},
    {'label': 'adventure', 'icon': Icons.terrain, 'hue': BitmapDescriptor.hueBlue},
    {'label': 'history', 'icon': Icons.museum, 'hue': BitmapDescriptor.hueYellow},
  ];

  @override
  void initState() {
    super.initState();
    _audioGuide.init();
    _loadPlacesFromJson();
  }

  @override
  void dispose() {
    _audioGuide.dispose();
    super.dispose();
  }

  // ─── Load POIs from bundled places.json ──────────────────────────────────
  Future<void> _loadPlacesFromJson() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/places.json');
      final List<dynamic> data = json.decode(jsonString);
      _places = data.cast<Map<String, dynamic>>();
      _buildMarkers();
    } catch (e) {
      debugPrint('Error loading places.json: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  // ─── Build markers with category-based colors ────────────────────────────
  void _buildMarkers() {
    final filtered = _selectedCategory == 'All'
        ? _places
        : _places.where((p) => p['category'] == _selectedCategory).toList();

    final newMarkers = <Marker>{};

    for (final place in filtered) {
      final lat = (place['lat'] as num?)?.toDouble();
      final lng = (place['lng'] as num?)?.toDouble();
      if (lat == null || lng == null) continue;

      newMarkers.add(
        Marker(
          markerId: MarkerId(place['xid'] ?? place['name']),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(_hueForCategory(place['category'])),
          infoWindow: InfoWindow(
            title: place['name'] ?? 'Unknown',
            snippet: _capitalize(place['category'] ?? ''),
          ),
          onTap: () => _showPlaceBottomSheet(place),
        ),
      );
    }

    if (mounted) {
      setState(() => _markers
        ..clear()
        ..addAll(newMarkers));
    }
  }

  // ─── Category → marker hue ──────────────────────────────────────────────
  double _hueForCategory(String? category) {
    switch (category?.toLowerCase()) {
      case 'pilgrimage':
        return BitmapDescriptor.hueRose;
      case 'nature':
        return BitmapDescriptor.hueGreen;
      case 'food':
        return BitmapDescriptor.hueOrange;
      case 'adventure':
        return BitmapDescriptor.hueBlue;
      case 'history':
        return BitmapDescriptor.hueYellow;
      default:
        return BitmapDescriptor.hueRed;
    }
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

  // ─── Bottom sheet with place details + audio guide ───────────────────────
  void _showPlaceBottomSheet(Map<String, dynamic> place) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _PlaceBottomSheet(
        place: place,
        audioGuide: _audioGuide,
      ),
    );
  }

  // ─── Filter change ─────────────────────────────────────────────────────
  void _onCategorySelected(String category) {
    setState(() => _selectedCategory = category);
    _buildMarkers();
>>>>>>> 4a346b892c20e97bdcde7515fb32eabfd9275833
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
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
=======
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),

          // Top bar with back button + title
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Row(
                children: [
                  // Back button
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surface.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                      boxShadow: AppTheme.ambientShadow,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_rounded, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Title pill
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.surface.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                        boxShadow: AppTheme.ambientShadow,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.explore_rounded, size: 18, color: AppTheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Explore Nashik',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: 16,
                              color: AppTheme.primary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${_markers.length} places',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Category filter chips at bottom
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (ctx, i) {
                  final cat = _categories[i];
                  final isSelected = _selectedCategory == cat['label'];
                  return GestureDetector(
                    onTap: () => _onCategorySelected(cat['label'] as String),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primary
                            : AppTheme.surface.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                        boxShadow: AppTheme.ambientShadow,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            cat['icon'] as IconData,
                            size: 16,
                            color: isSelected ? AppTheme.onPrimary : AppTheme.onSurface,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _capitalize(cat['label'] as String),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? AppTheme.onPrimary : AppTheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Loading indicator
          if (_loading)
            const Center(child: CircularProgressIndicator(color: AppTheme.primary)),

          // My location FAB
          Positioned(
            bottom: 80,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: AppTheme.ambientShadow,
              ),
              child: FloatingActionButton.small(
                heroTag: 'location',
                backgroundColor: AppTheme.surface,
                onPressed: () {
                  _mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(_center, 12),
                  );
                },
                child: const Icon(Icons.my_location_rounded, color: AppTheme.primary, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom Sheet Widget ───────────────────────────────────────────────────
class _PlaceBottomSheet extends StatefulWidget {
  final Map<String, dynamic> place;
  final AudioGuideService audioGuide;

  const _PlaceBottomSheet({required this.place, required this.audioGuide});

  @override
  State<_PlaceBottomSheet> createState() => _PlaceBottomSheetState();
}

class _PlaceBottomSheetState extends State<_PlaceBottomSheet> {
  bool _audioLoading = false;
  bool _audioPlaying = false;
  String? _summary;

  Future<void> _onAudioTap() async {
    if (_audioPlaying) {
      await widget.audioGuide.stop();
      setState(() => _audioPlaying = false);
      return;
    }

    setState(() => _audioLoading = true);

    try {
      _summary ??= await widget.audioGuide.getSummary(
        placeId: widget.place['xid'] ?? widget.place['name'],
        name: widget.place['name'] ?? '',
        description: widget.place['description'],
        category: widget.place['category'],
        lat: (widget.place['lat'] as num?)?.toDouble(),
        lng: (widget.place['lng'] as num?)?.toDouble(),
      );

      setState(() {
        _audioLoading = false;
        _audioPlaying = true;
      });

      await widget.audioGuide.speak(_summary!);

      if (mounted) setState(() => _audioPlaying = false);
    } catch (e) {
      if (mounted) {
        setState(() {
          _audioLoading = false;
          _audioPlaying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final place = widget.place;
    final name = place['name'] ?? 'Unknown';
    final description = place['description'] ?? '';
    final category = place['category'] ?? '';
    final rating = place['rate'] ?? 0;
    final kinds = place['kinds'] ?? '';
    final photo = place['photo'] as String?;

    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusMd)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Photo header (if available)
          if (photo != null && photo.startsWith('assets/'))
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(photo),
                  fit: BoxFit.cover,
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category label
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryFixedDim.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                      ),
                      child: Text(
                        category.toString().toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Rating stars
                    if (rating > 0) ...[
                      const Icon(Icons.star_rounded, size: 16, color: AppTheme.secondary),
                      const SizedBox(width: 2),
                      Text(
                        '$rating/5',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.secondary,
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 12),

                // Place name + audio guide button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Audio guide button (inline — no separate widget needed)
                    GestureDetector(
                      onTap: _audioLoading ? null : _onAudioTap,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _audioPlaying
                              ? AppTheme.error
                              : _audioLoading
                                  ? AppTheme.outline
                                  : AppTheme.secondary,
                          boxShadow: [
                            BoxShadow(
                              color: (_audioPlaying
                                      ? AppTheme.error
                                      : AppTheme.secondary)
                                  .withValues(alpha: 0.3),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: _audioLoading
                            ? const Padding(
                                padding: EdgeInsets.all(10),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(
                                _audioPlaying
                                    ? Icons.stop_rounded
                                    : Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Audio label
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    _audioPlaying ? 'Tap to stop' : 'Audio Guide',
                    style: TextStyle(
                      fontSize: 10,
                      color: _audioPlaying ? AppTheme.error : AppTheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Description
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),

                // Show summary text if available
                if (_summary != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryContainer.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.secondaryContainer.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.auto_awesome, size: 14, color: AppTheme.secondary),
                            const SizedBox(width: 6),
                            Text(
                              'AI Summary',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.secondary,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _summary!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                // Tags
                if (kinds.isNotEmpty)
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: kinds.split(',').map((kind) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                        ),
                        child: Text(
                          kind.trim(),
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                const SizedBox(height: 16),
              ],
            ),
>>>>>>> 4a346b892c20e97bdcde7515fb32eabfd9275833
          ),
        ],
      ),
    );
  }
}
