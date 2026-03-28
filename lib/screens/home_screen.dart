import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../utils/constants.dart';
import '../widgets/gradient_button.dart';
import '../widgets/section_header.dart';
import '../widgets/place_card.dart';
import '../widgets/event_card.dart';
import '../widgets/glassmorphism_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/weather_service.dart';

/// Screen 4: Main Explore Nashik Home Hub
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  List<Map<String, String>> _bookmarkedPlaces = [];

  @override
  void initState() {
    super.initState();
    _loadSavedPlaces();
  }

  Future<void> _loadSavedPlaces() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('savedPlaces') ?? [];
    
    final matches = <Map<String, String>>[];
    for (var name in saved) {
      final attraction = MockData.topAttractions.where((p) => p['name'] == name).firstOrNull;
      if (attraction != null) { matches.add(attraction); continue; }
      
      final cuisine = MockData.topCuisine.where((p) => p['name'] == name).firstOrNull;
      if (cuisine != null) {
         matches.add({
           'name': cuisine['name']!,
           'description': cuisine['type']!,
           'image': cuisine['icon']!,
           'rating': cuisine['rating']!,
           'category': 'food',
         });
         continue; 
      }
      
      for (var list in MockData.businesses.values) {
        final biz = list.where((b) => b['name'] == name).firstOrNull;
        if (biz != null) {
           matches.add({
             'name': biz['name']!,
             'description': biz['desc']!,
             'image': biz['image'] ?? 'assets/images/tourisms.jpeg',
             'rating': biz['rating']!,
             'category': 'business',
           });
           break;
        }
      }
    }
    
    setState(() {
      _bookmarkedPlaces = matches;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Cinematic Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background for app.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.55),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.exploreNashik,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppStrings.tagline,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/events'),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.notifications_outlined, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Weather & Crowd Tags
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        _WeatherWidget(),
                        const SizedBox(width: 12),
                        _CrowdWidget(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Build Your Plan CTA
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GradientButton(
                      label: AppStrings.buildPlanToday,
                      icon: Icons.auto_awesome,
                      onPressed: () => Navigator.pushNamed(context, '/plan-builder'),
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Section tabs horizontal scroll
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children: [
                        _SectionTab(icon: Icons.place, label: 'Attractions', onTap: () => Navigator.pushNamed(context, '/top-attractions')),
                        _SectionTab(icon: Icons.restaurant, label: 'Cuisine', onTap: () => Navigator.pushNamed(context, '/cuisine')),
                        _SectionTab(icon: Icons.storefront, label: 'Business', onTap: () => Navigator.pushNamed(context, '/local-business')),
                        _SectionTab(icon: Icons.directions_car, label: 'Road Trips', onTap: () => Navigator.pushNamed(context, '/road-trips')),
                        _SectionTab(icon: Icons.camera_alt, label: 'Stories', onTap: () => Navigator.pushNamed(context, '/traveler-experience')),
                        _SectionTab(icon: Icons.event, label: 'Events', onTap: () => Navigator.pushNamed(context, '/events')),
                        _SectionTab(icon: Icons.celebration, label: 'Festivals', onTap: () => Navigator.pushNamed(context, '/festivals')),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Saved Places 
                  if (_bookmarkedPlaces.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SectionHeader(
                        title: 'Saved Places',
                        onViewAll: () => Navigator.pushNamed(context, '/user-profile'),
                      ),
                    ),
                    SizedBox(
                      height: 156,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: _bookmarkedPlaces.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 12),
                        itemBuilder: (context, i) {
                          final place = _bookmarkedPlaces[i];
                          return SizedBox(
                            width: 260,
                            child: PlaceCard(
                              emoji: place['image']!,
                              name: place['name']!,
                              description: place['description']!,
                              rating: place['rating'],
                              onTap: () => Navigator.pushNamed(context, '/place-detail', arguments: place),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Top Attractions preview
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SectionHeader(
                      title: AppStrings.topAttractions,
                      onViewAll: () => Navigator.pushNamed(context, '/top-attractions'),
                    ),
                  ),
                  SizedBox(
                    height: 156,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: MockData.topAttractions.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                      itemBuilder: (context, i) {
                        final place = MockData.topAttractions[i];
                        return SizedBox(
                          width: 260,
                          child: PlaceCard(
                            emoji: place['image']!,
                            name: place['name']!,
                            description: place['description']!,
                            rating: place['rating'],
                            onTap: () => Navigator.pushNamed(context, '/place-detail', arguments: place),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Cuisine preview
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SectionHeader(
                      title: AppStrings.cuisine,
                      onViewAll: () => Navigator.pushNamed(context, '/cuisine'),
                    ),
                  ),
                  SizedBox(
                    height: 156,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: MockData.topCuisine.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                      itemBuilder: (context, i) {
                        final food = MockData.topCuisine[i];
                        return SizedBox(
                          width: 240,
                          child: PlaceCard(
                            emoji: food['icon']!,
                            name: food['name']!,
                            description: food['type']!,
                            rating: food['rating'],
                            onTap: () => Navigator.pushNamed(context, '/cuisine'),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Upcoming Events
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SectionHeader(
                      title: AppStrings.eventsNashik,
                      onViewAll: () => Navigator.pushNamed(context, '/events'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: MockData.dailyEvents.map((event) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: EventCard(
                          icon: event['icon']!,
                          name: event['name']!,
                          timeOrDate: event['time']!,
                          description: event['desc']!,
                          onTap: () => Navigator.pushNamed(context, '/events'),
                        ),
                      )).toList(),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Festivals preview
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SectionHeader(
                      title: AppStrings.festivalsDhamaka,
                      onViewAll: () => Navigator.pushNamed(context, '/festivals'),
                    ),
                  ),
                  SizedBox(
                    height: 180,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: MockData.festivals.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                      itemBuilder: (context, i) {
                        final fest = MockData.festivals[i];
                        return SizedBox(
                          width: 280,
                          child: EventCard(
                            icon: fest['icon']!,
                            name: fest['name']!,
                            timeOrDate: fest['date']!,
                            description: fest['desc']!,
                            onTap: () => Navigator.pushNamed(context, '/festivals'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Glassmorphism bottom nav
          GlassmorphismNav(
            currentIndex: _navIndex,
            onTap: (i) {
              setState(() => _navIndex = i);
              switch (i) {
                case 1:
                  Navigator.pushNamed(context, '/map');
                  break;
                case 2:
                  Navigator.pushNamed(context, '/plan-builder');
                  break;
                case 3:
                  Navigator.pushNamed(context, '/sos');
                  break;
                case 4:
                  Navigator.pushNamed(context, '/user-profile');
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}

class _SectionTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _SectionTab({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.white, Color(0xFFF5EFE6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            border: Border.all(color: const Color(0xFFE0D5C5)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 16, color: AppTheme.onSurface),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WeatherWidget extends StatefulWidget {
  @override
  State<_WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<_WeatherWidget> {
  Map<String, dynamic>? _weather;

  @override
  void initState() {
    super.initState();
    WeatherService().fetchNashikWeather().then((data) {
      if (mounted) setState(() => _weather = data);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_weather == null) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(_weather!['iconUrl'] as String, width: 20, height: 20),
          const SizedBox(width: 6),
          Text(
            '${_weather!['temp']}°C | ${_weather!['condition']}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CrowdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    Color badgeColor;
    String label;

    if (hour >= 6 && hour <= 11) {
      badgeColor = Colors.green;
      label = 'Low Crowd';
    } else if (hour >= 12 && hour <= 17) {
      badgeColor = Colors.orange;
      label = 'Medium Crowd';
    } else if (hour >= 18 && hour <= 22) {
      badgeColor = Colors.red;
      label = 'High Crowd';
    } else {
      badgeColor = Colors.grey;
      label = 'Closed';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.groups, size: 16, color: badgeColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: badgeColor,
            ),
          ),
        ],
      ),
    );
  }
}

