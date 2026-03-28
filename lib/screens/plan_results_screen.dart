import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';
import '../widgets/plan_card.dart';

/// Screen 6: AI Plan Results — 3 generated plans
class PlanResultsScreen extends StatelessWidget {
  const PlanResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final aiPlanData = ModalRoute.of(context)?.settings.arguments;
    final List<String> aiStops = aiPlanData is List<String> 
        ? aiPlanData 
        : (aiPlanData is String ? [aiPlanData] : []);
    
    // Wire to real Gemini API via Firebase Functions
    final plans = aiPlanData != null 
      ? [{
          'name': 'AI Custom Itinerary',
          'tagline': 'Crafted specifically to your preferences',
          'stops': aiStops,
          'estimatedCost': 'Custom',
          'highlights': 'Powered by Gemini',
          'duration': 'Custom'
        }]
      : MockData.fallbackPlans;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your AI Plans'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Welcomepage.jpeg',
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

                // AI badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.auto_awesome, size: 16, color: AppTheme.secondary),
                      const SizedBox(width: 6),
                      Text(
                        'Powered by Gemini AI',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'We crafted 3 unique plans just for you',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 24),

                // Plan cards
                ...plans.asMap().entries.map((entry) {
                  final index = entry.key;
                  final plan = entry.value;

                  final bgAssets = [
                    'assets/images/trimbakeshwar.jpg', // Pilgrim's path
                    'assets/images/sula_vineyards.jpg', // Wine & Dine
                    'assets/images/anjaneri_hills.jpg', // Hidden Nashik
                  ];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: PlanCard(
                      name: plan['name'] as String,
                      tagline: plan['tagline'] as String,
                      stops: List<String>.from(plan['stops'] as List),
                      estimatedCost: plan['estimatedCost'] as String,
                      highlights: plan['highlights'] as String,
                      duration: plan['duration'] as String,
                      bgImageAsset: index < bgAssets.length ? bgAssets[index] : null,
                      onStart: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Starting: ${plan['name']}'),
                            backgroundColor: AppTheme.primary,
                          ),
                        );
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      },
                    ),
                  );
                }),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
