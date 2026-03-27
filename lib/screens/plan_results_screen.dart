import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';
import '../widgets/plan_card.dart';

/// Screen 6: AI Plan Results — 3 generated plans
class PlanResultsScreen extends StatelessWidget {
  const PlanResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: wire to real Gemini API via Firebase Functions
    final plans = MockData.fallbackPlans;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your AI Plans'),
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

            // AI badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.secondaryContainer.withValues(alpha: 0.15),
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
                color: AppTheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 24),

            // Plan cards
            ...plans.map((plan) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: PlanCard(
                name: plan['name'] as String,
                tagline: plan['tagline'] as String,
                stops: List<String>.from(plan['stops'] as List),
                estimatedCost: plan['estimatedCost'] as String,
                highlights: plan['highlights'] as String,
                duration: plan['duration'] as String,
                onStart: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Starting: ${plan['name']}'),
                      backgroundColor: AppTheme.primary,
                    ),
                  );
                },
              ),
            )),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
