import 'package:flutter/material.dart';
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

  List<Map<String, String>> get _filteredCuisine {
    if (_selectedCategory == 'All') return MockData.topCuisine;
    return MockData.topCuisine.where((c) => c['type'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.cuisineTitle),
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
              'Taste the authentic flavors of Nashik',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
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
                  colors: [Color(0xFF9D4400), Color(0xFFFE7F2F)],
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
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '${food['icon']} ${food['name']}  ⭐ ${food['rating']}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
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
            ..._filteredCuisine.map((food) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: PlaceCard(
                emoji: food['icon']!,
                name: food['name']!,
                description: food['type']!,
                rating: food['rating'],
                onTap: () {},
              ),
            )),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
