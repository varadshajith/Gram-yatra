import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../utils/constants.dart';
import '../widgets/section_header.dart';
import '../widgets/event_card.dart';
import '../widgets/app_image.dart';

/// Screen 15: Festivals Dhamaka
class FestivalsScreen extends StatelessWidget {
  const FestivalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.festivalsTitle),
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
              'Nashik celebrates with unmatched energy and devotion',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 24),

            // Hero banner
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                   const AppImage('assets/images/Kumbhamela.jpeg'),
                   Container(
                     decoration: BoxDecoration(
                       gradient: LinearGradient(
                         colors: [Color(0xFF4E021E).withValues(alpha: 0.7), Color(0xFF6B1A33).withValues(alpha: 0.7)],
                         begin: Alignment.topLeft,
                         end: Alignment.bottomRight,
                       ),
                     ),
                   ),
                   Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('🎉', style: TextStyle(fontSize: 40)),
                        const SizedBox(height: 12),
                        Text(
                          'Festival Capital\nof Maharashtra',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'From Kumbh Mela to Rang Panchami, experience festivals like nowhere else.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.primaryFixedDim.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const SectionHeader(title: 'Major Festivals'),

            ...MockData.festivals.map((fest) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: EventCard(
                icon: fest['icon']!,
                name: fest['name']!,
                timeOrDate: fest['date']!,
                description: fest['desc']!,
                highlight: fest['highlight'],
              ),
            )),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
