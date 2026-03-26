import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../utils/constants.dart';
import '../widgets/gradient_button.dart';
import '../widgets/section_header.dart';
import '../widgets/place_card.dart';
import '../widgets/event_card.dart';
import '../widgets/glassmorphism_nav.dart';

/// Screen 4: Main Explore Nashik Home Hub
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                                color: AppTheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppStrings.tagline,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.onSurfaceVariant,
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
                              color: AppTheme.surfaceContainerLow,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.notifications_outlined, color: AppTheme.onSurfaceVariant),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

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
                  Navigator.pushNamed(context, '/top-attractions');
                  break;
                case 2:
                  Navigator.pushNamed(context, '/plan-builder');
                  break;
                case 3:
                  Navigator.pushNamed(context, '/events');
                  break;
                case 4:
                  // TODO: wire to profile
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
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppTheme.radiusFull),
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
                    fontWeight: FontWeight.w500,
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
