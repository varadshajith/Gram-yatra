import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../utils/constants.dart';
import '../widgets/section_header.dart';
import '../widgets/place_card.dart';

/// Screen 7: Top 5 Attractions with AR/VR option
class TopAttractionsScreen extends StatelessWidget {
  const TopAttractionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.top5Places),
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
              'The must-visit destinations of Nashik',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 24),

            const SectionHeader(title: 'Must Visit'),

            ...MockData.topAttractions.asMap().entries.map((entry) {
              final i = entry.key;
              final place = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    // Rank badge
                    Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${i + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          place['category']!.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    PlaceCard(
                      emoji: place['image']!,
                      name: place['name']!,
                      description: place['description']!,
                      rating: place['rating'],
                      onTap: () => Navigator.pushNamed(context, '/place-detail', arguments: place),
                      action: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.tertiaryContainer.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.view_in_ar_rounded, size: 14, color: AppTheme.tertiary),
                            const SizedBox(width: 4),
                            Text(
                              'AR/VR',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppTheme.tertiary,
                                letterSpacing: 0.5,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
