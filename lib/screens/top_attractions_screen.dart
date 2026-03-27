import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../utils/constants.dart';
import '../widgets/section_header.dart';


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
                          place['category']!.replaceAll('_', ' ').toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/place-detail', arguments: place),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                          boxShadow: AppTheme.ambientShadow,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(AppTheme.radiusMd)),
                              child: Image.asset(
                                place['image']!,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 180,
                                  color: const Color(0xFF7B2D8B),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(AppTheme.spacingMedium),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          place['name']!,
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.star_rounded, size: 16, color: AppTheme.secondary),
                                          const SizedBox(width: 4),
                                          Text(
                                            place['rating']!,
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppTheme.secondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    place['description']!,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppTheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
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
