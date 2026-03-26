import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../utils/constants.dart';

/// Screen 10: Local Business Discovery
class LocalBusinessScreen extends StatelessWidget {
  const LocalBusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.discoverBusiness),
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
              'Support and explore Nashik\'s thriving industries',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 20),

            // Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search_rounded, color: AppTheme.onSurfaceVariant, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    'Search by category...',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.outline,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Category grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: MockData.businessCategories.length,
              itemBuilder: (context, i) {
                final cat = MockData.businessCategories[i];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/business-category',
                    arguments: cat['name'],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      boxShadow: AppTheme.ambientShadow,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(cat['icon']!, style: const TextStyle(fontSize: 36)),
                        const SizedBox(height: 12),
                        Text(
                          cat['name']!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${cat['count']} businesses',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
