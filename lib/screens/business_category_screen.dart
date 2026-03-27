import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';
import '../widgets/section_header.dart';
import '../widgets/place_card.dart';

/// Screen 11: Businesses in a Category
class BusinessCategoryScreen extends StatefulWidget {
  const BusinessCategoryScreen({super.key});

  @override
  State<BusinessCategoryScreen> createState() => _BusinessCategoryScreenState();
}

class _BusinessCategoryScreenState extends State<BusinessCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as String? ?? 'Agriculture';
    final allBusinesses = MockData.businesses[category] ?? [];
    
    final businesses = allBusinesses.where((biz) {
      final name = biz['name']?.toLowerCase() ?? '';
      final desc = biz['desc']?.toLowerCase() ?? '';
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || desc.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Manufacturing.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.55),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                Text(
                  'Discover $category businesses in Nashik',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 16),

                // Search bar
                TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search $category...',
                    hintStyle: const TextStyle(color: Colors.white38),
                    prefixIcon: const Icon(Icons.search_rounded, color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),

                const SizedBox(height: 24),

                SectionHeader(title: '$category in Nashik'),

                ...businesses.map((biz) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PlaceCard(
                    emoji: biz['image'] ?? _fallbackImage(category),
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
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _fallbackImage(String category) {
    switch (category) {
      case 'Architecture': return 'assets/images/architecture.jpeg';
      case 'Agriculture': return 'assets/images/Agriculture.jpeg';
      case 'Manufacturing': return 'assets/images/taparia.jpeg';
      case 'Tourism Services': return 'assets/images/tourisms.jpeg';
      case 'Traditional Fashion': return 'assets/images/traditionalfashion.jpeg';
      default: return 'assets/images/tourisms.jpeg';
    }
  }
}
