import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../utils/constants.dart';
import '../widgets/category_chip.dart';
import '../widgets/section_header.dart';
import '../widgets/place_card.dart';

/// Screen 9: Cuisine Discovery
class CuisineScreen extends StatefulWidget {
  const CuisineScreen({super.key});

  @override
  State<CuisineScreen> createState() => _CuisineScreenState();
}

class _CuisineScreenState extends State<CuisineScreen> {
  String _selectedCategory = 'All';
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    try {
      Position position = await Geolocator.getCurrentPosition();
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    } catch (e) {
      // ignore
    }
  }

  List<Map<String, String>> get _filteredCuisine {
    if (_selectedCategory == 'All') return MockData.topCuisine;
    return MockData.topCuisine.where((c) => c['type'] == _selectedCategory).toList();
  }

  String _getDistance(Map<String, String> food) {
    if (_currentPosition == null || !food.containsKey('lat') || !food.containsKey('lng')) return '';
    final lat = double.tryParse(food['lat']!) ?? 0;
    final lng = double.tryParse(food['lng']!) ?? 0;
    if (lat == 0 || lng == 0) return '';
    final distanceInMeters = Geolocator.distanceBetween(
      _currentPosition!.latitude, _currentPosition!.longitude, lat, lng);
    return '${(distanceInMeters / 1000).toStringAsFixed(1)} km';
  }

  Future<void> _saveToPlan(Map<String, String> food) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('savedPlaces') ?? [];
    if (!saved.contains(food['name'])) {
      saved.add(food['name']!);
      await prefs.setStringList('savedPlaces', saved);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${food['name']} saved!')),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${food['name']} is already saved.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fallback for loading/errors
      appBar: AppBar(
        title: Text(AppStrings.cuisineTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Misal.jpeg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFF1A0A2E)),
            ),
          ),
          
          // 2. Dark Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.55),
            ),
          ),
          
          // 3. Scrollable Content
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  Text(
                    'Taste the authentic flavors of Nashik',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Top recommendations header
                  const SectionHeader(title: 'Top 5 Recommendations'),

                  // Top 5 highlight banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.secondary, AppTheme.secondaryContainer],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '🔥 Must Try in Nashik',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...MockData.topCuisine.map((food) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.asset(
                                  food['icon']!,
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 32,
                                    height: 32,
                                    color: const Color(0xFF7B2D8B),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  '${food['name']}  ⭐ ${food['rating']}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Category filter
                  const SectionHeader(title: 'Browse by Category'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: MockData.cuisineCategories.map((cat) => CategoryChip(
                      label: cat,
                      isSelected: _selectedCategory == cat,
                      onTap: () => setState(() => _selectedCategory = cat),
                    )).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Filtered results
                  SizedBox(
                    height: 100, // Fixed height for horizontal PlaceCards
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filteredCuisine.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final food = _filteredCuisine[index];
                        return SizedBox(
                          width: 320, // Wider for distance and button
                          child: PlaceCard(
                            emoji: food['icon']!,
                            name: food['name']!,
                            description: food['type']!,
                            rating: food['rating'],
                            trailing: _getDistance(food),
                            action: IconButton(
                              icon: const Icon(Icons.bookmark_add_outlined, color: AppTheme.primary),
                              onPressed: () => _saveToPlan(food),
                            ),
                            onTap: () {},
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
