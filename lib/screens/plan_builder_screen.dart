import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../widgets/gradient_button.dart';
import '../widgets/category_chip.dart';

/// Screen 5: AI Plan Builder Form
class PlanBuilderScreen extends StatefulWidget {
  const PlanBuilderScreen({super.key});

  @override
  State<PlanBuilderScreen> createState() => _PlanBuilderScreenState();
}

class _PlanBuilderScreenState extends State<PlanBuilderScreen> {
  double _hours = 4;
  double _budget = 1000;
  final Set<String> _selectedPrefs = {};

  final _preferences = [
    {'label': AppStrings.pilgrimage, 'icon': Icons.account_balance},
    {'label': AppStrings.nature, 'icon': Icons.park},
    {'label': AppStrings.food, 'icon': Icons.restaurant},
    {'label': AppStrings.art, 'icon': Icons.palette},
    {'label': AppStrings.shopping, 'icon': Icons.shopping_bag},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.planBuilderTitle),
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
            const SizedBox(height: 16),

            // Subtitle
            Text(
              'Let AI craft the perfect Nashik day for you',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 32),

            // Current location
            Text(AppStrings.currentLocation, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              child: Row(
                children: [
                  const Icon(Icons.my_location_rounded, color: AppTheme.secondary, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    'Nashik City Center',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Text(
                    'Change',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Time preference
            Text(AppStrings.timePref, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_hours.toInt()} hours',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
                Text(
                  'Half day',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: AppTheme.primary,
                inactiveTrackColor: AppTheme.surfaceContainerHighest,
                thumbColor: AppTheme.primary,
                overlayColor: AppTheme.primaryFixedDim.withValues(alpha: 0.2),
                trackHeight: 4,
              ),
              child: Slider(
                value: _hours,
                min: 1,
                max: 12,
                divisions: 11,
                onChanged: (v) => setState(() => _hours = v),
              ),
            ),

            const SizedBox(height: 24),

            // Budget
            Text(AppStrings.budget, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${_budget.toInt()}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
                Text(
                  _budget <= 500 ? 'Budget' : _budget <= 2000 ? 'Mid-range' : 'Luxury',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: AppTheme.secondary,
                inactiveTrackColor: AppTheme.surfaceContainerHighest,
                thumbColor: AppTheme.secondary,
                overlayColor: AppTheme.secondaryContainer.withValues(alpha: 0.2),
                trackHeight: 4,
              ),
              child: Slider(
                value: _budget,
                min: 100,
                max: 5000,
                divisions: 49,
                onChanged: (v) => setState(() => _budget = v),
              ),
            ),

            const SizedBox(height: 28),

            // Preferences
            Text(AppStrings.preferences, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _preferences.map((pref) => CategoryChip(
                label: pref['label'] as String,
                icon: pref['icon'] as IconData,
                isSelected: _selectedPrefs.contains(pref['label']),
                onTap: () => setState(() {
                  final label = pref['label'] as String;
                  if (_selectedPrefs.contains(label)) {
                    _selectedPrefs.remove(label);
                  } else {
                    _selectedPrefs.add(label);
                  }
                }),
              )).toList(),
            ),

            const SizedBox(height: 40),

            // Generate
            GradientButton(
              label: AppStrings.generatePlan,
              onPressed: () {
                Navigator.pushNamed(context, '/plan-results');
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
