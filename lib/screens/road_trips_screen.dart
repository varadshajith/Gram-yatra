import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../utils/constants.dart';
import '../widgets/section_header.dart';
import '../widgets/app_image.dart';
import 'package:url_launcher/url_launcher.dart';

/// Screen 12: Road Trips from Nashik
class RoadTripsScreen extends StatelessWidget {
  const RoadTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.roadTripsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            Text(
              'Scenic drives and day trips around Nashik',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 24),

            const SectionHeader(title: 'Popular Trips'),

            ...MockData.roadTrips.map((trip) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _RoadTripCard(trip: trip),
            )),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _RoadTripCard extends StatefulWidget {
  final Map<String, String> trip;

  const _RoadTripCard({required this.trip});

  @override
  State<_RoadTripCard> createState() => _RoadTripCardState();
}

class _RoadTripCardState extends State<_RoadTripCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final trip = widget.trip;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          boxShadow: AppTheme.ambientShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: AppImage(trip['icon']!),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip['name']!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        children: [
                          _Chip(icon: Icons.directions_car, label: trip['distance']!),
                          _Chip(icon: Icons.schedule, label: trip['time']!),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  _expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                  color: AppTheme.onSurfaceVariant,
                ),
              ],
            ),

            // Best season
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.tertiaryContainer.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                ),
                child: Text(
                  '🗓 Best: ${trip['season']}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: AppTheme.tertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            if (_expanded) ...[
              const SizedBox(height: 16),

              Text(
                trip['desc']!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 16),

              // Map placeholder
              GestureDetector(
                onTap: () async {
                  final query = Uri.encodeComponent('${trip['name']} Nashik');
                  final url = Uri.parse('https://maps.google.com/?q=$query');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not launch maps')),
                      );
                    }
                  }
                },
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map_rounded, size: 32, color: AppTheme.onSurfaceVariant),
                        SizedBox(height: 4),
                        Text('Route Map', style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // AI traffic alert
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryContainer.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, size: 20, color: AppTheme.secondary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.aiTrafficAlert,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppTheme.secondary,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Light traffic expected. Best time to leave: 7:00 AM. Enjoy the scenic Ghoti road!',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13,
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Chip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppTheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 11, color: AppTheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
