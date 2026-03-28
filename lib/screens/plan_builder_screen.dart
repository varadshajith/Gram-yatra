import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../widgets/gradient_button.dart';
import '../widgets/category_chip.dart';
import '../services/gemini_services.dart';

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
  String _groupType = 'Friends'; // Default for Yash's service
  String _crowdLevel = 'low';    // Default for Yash's service

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
                const SizedBox(height: 16),

                // Subtitle
                Text(
                  'Let AI craft the perfect Nashik day for you',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 32),

                // Current location
                Text(AppStrings.currentLocation, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
                const SizedBox(height: 12),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: TextEditingController(text: 'Nashik City Center'),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.my_location_rounded, color: AppTheme.secondary, size: 20),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.1),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Time preference
                Text(AppStrings.timePref, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_hours.toInt()} hours',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.secondary,
                      ),
                    ),
                    Text(
                      'Half day',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: AppTheme.secondary,
                    inactiveTrackColor: Colors.white.withValues(alpha: 0.2),
                    thumbColor: AppTheme.secondary,
                    overlayColor: AppTheme.secondaryContainer.withValues(alpha: 0.2),
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
                Text(AppStrings.budget, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${_budget.toInt()}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.secondary,
                      ),
                    ),
                    Text(
                      _budget <= 500 ? 'Budget' : _budget <= 2000 ? 'Mid-range' : 'Luxury',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: AppTheme.secondary,
                    inactiveTrackColor: Colors.white.withValues(alpha: 0.2),
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
                Text(AppStrings.preferences, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
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
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (ctx) => const Center(child: CircularProgressIndicator()),
                    );
                    try {
                      final planData = await GeminiDirectService().generatePlan(
                        hours: _hours.toInt(),
                        budget: _budget.toInt(),
                        preferences: _selectedPrefs.join(','),
                        groupType: _groupType,
                        crowdLevel: _crowdLevel,
                        lat: 0,
                        lng: 0,
                      );

                      // Convert to List<String> for Tanvi's results screen
                      final List<String> stops = planData.map((s) => s['place'].toString()).toList();

                      if (context.mounted) {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/plan-results', arguments: stops);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Error generating plan')),
                        );
                      }
                    }
                  },
                ),


                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
