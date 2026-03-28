import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../widgets/app_image.dart';

/// Screen 8: Individual Place Detail
class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final place = ModalRoute.of(context)?.settings.arguments as Map<String, String>? ?? {};
    final name = place['name'] ?? 'Place';
    final description = place['description'] ?? '';
    final emoji = place['image'] ?? '📍';
    final rating = place['rating'] ?? '4.5';
    final category = place['category'] ?? 'attraction';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: AppImage(emoji),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.4),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    // Hero header - keeping it for the back button and pinned behavior
                    SliverAppBar(
                      expandedHeight: 260,
                      pinned: true,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_rounded, size: 20, color: Colors.white),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      flexibleSpace: const FlexibleSpaceBar(
                        background: SizedBox.shrink(),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category label
                            Text(
                              category.replaceAll('_', ' ').toUpperCase(),
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.white70,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Name
                            Text(
                              name,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Rating
                            Row(
                              children: [
                                const Icon(Icons.star_rounded, size: 20, color: AppTheme.secondary),
                                const SizedBox(width: 4),
                                Text(
                                  rating,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppTheme.secondary,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.schedule, size: 14, color: Colors.white70),
                                      const SizedBox(width: 4),
                                      Text(
                                        '6 AM – 9 PM',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontSize: 12,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Description
                            Text(
                              description,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                                height: 1.6,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Quick info
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                              ),
                              child: Column(
                                children: [
                                  _InfoRow(icon: Icons.directions_car, label: 'Distance', value: '12 km from city center'),
                                  const SizedBox(height: 16),
                                  _InfoRow(icon: Icons.currency_rupee, label: 'Entry Fee', value: 'Free'),
                                  const SizedBox(height: 16),
                                  _InfoRow(icon: Icons.calendar_today, label: 'Best Time', value: 'Oct – Feb'),
                                ],
                              ),
                            ),

                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add_rounded),
                          label: const Text('Add to My Plan'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: AppTheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                            ),
                          ),
                          onPressed: () {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('$name added to your plan!'),
                                  backgroundColor: AppTheme.primary,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.view_in_ar_rounded, color: Colors.white),
                          label: Text(
                            'AR/VR View',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/ar-view', arguments: name);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white70),
        const SizedBox(width: 12),
        Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white70,
        )),
        const Spacer(),
        Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        )),
      ],
    );
  }
}
