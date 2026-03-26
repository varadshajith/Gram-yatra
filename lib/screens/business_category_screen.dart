import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';
import '../widgets/section_header.dart';
import '../widgets/place_card.dart';

/// Screen 11: Businesses in a Category
class BusinessCategoryScreen extends StatelessWidget {
  const BusinessCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as String? ?? 'Agriculture';
    final businesses = MockData.businesses[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
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
              'Discover $category businesses in Nashik',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 24),

            SectionHeader(title: '$category in Nashik'),

            ...businesses.map((biz) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: PlaceCard(
                emoji: _categoryEmoji(category),
                name: biz['name']!,
                description: biz['desc']!,
                rating: biz['rating'],
                onTap: () {},
              ),
            )),

            if (businesses.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Text(
                    'No businesses found in this category',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String _categoryEmoji(String category) {
    switch (category) {
      case 'Architecture': return 'assets/images/arhitecture.jpeg';
      case 'Agriculture': return 'assets/images/Agriculture.jpeg';
      case 'Manufacturing': return 'assets/images/taparia.jpeg';
      case 'Tourism Services': return 'assets/images/tourisms.jpeg';
      case 'Traditional Fashion': return 'assets/images/traditionalfashion.jpeg';
      default: return 'assets/images/tourisms.jpeg';
    }
  }
}
