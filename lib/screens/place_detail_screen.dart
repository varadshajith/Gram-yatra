import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../widgets/gradient_button.dart';
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
      body: CustomScrollView(
        slivers: [
          // Hero header
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.surface.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_rounded, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  AppImage(emoji),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.5),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                    category.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 8),

                  // Name
                  Text(name, style: Theme.of(context).textTheme.headlineSmall),
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
                          color: AppTheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.schedule, size: 14, color: AppTheme.onSurfaceVariant),
                            const SizedBox(width: 4),
                            Text(
                              '6 AM – 9 PM',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 12,
                                color: AppTheme.onSurfaceVariant,
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
                      color: AppTheme.onSurfaceVariant,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Quick info
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
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

                  // CTA
                  GradientButton(
                    label: 'Add to My Plan',
                    icon: Icons.add_rounded,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$name added to your plan!'),
                          backgroundColor: AppTheme.primary,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
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
        Icon(icon, size: 18, color: AppTheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppTheme.onSurfaceVariant,
        )),
        const Spacer(),
        Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        )),
      ],
    );
  }
}
