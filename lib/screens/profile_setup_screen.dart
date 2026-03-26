import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../widgets/gradient_button.dart';
import '../widgets/category_chip.dart';

/// Screen 3: Profile Setup / Returning User
class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  final Set<String> _selectedPrefs = {};
  String? _selectedAge;

  final _preferences = [
    AppStrings.pilgrimage,
    AppStrings.nature,
    AppStrings.food,
    AppStrings.art,
    AppStrings.shopping,
  ];

  final _ageGroups = ['18–25', '25–35', '35–50', '50+'];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              Text(
                AppStrings.setupProfile,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Tell us about yourself to get personalized plans',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 32),

              // Name
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: AppStrings.nameHint,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 20, right: 8),
                    child: Icon(Icons.person_outline_rounded, color: AppTheme.onSurfaceVariant),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 0),
                ),
              ),

              const SizedBox(height: 32),

              // Preferences
              Text(
                AppStrings.whatExcites,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _preferences.map((pref) => CategoryChip(
                  label: pref,
                  isSelected: _selectedPrefs.contains(pref),
                  onTap: () => setState(() {
                    if (_selectedPrefs.contains(pref)) {
                      _selectedPrefs.remove(pref);
                    } else {
                      _selectedPrefs.add(pref);
                    }
                  }),
                )).toList(),
              ),

              const SizedBox(height: 32),

              // Age group
              Text(
                AppStrings.ageGroup,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _ageGroups.map((age) => CategoryChip(
                  label: age,
                  isSelected: _selectedAge == age,
                  onTap: () => setState(() => _selectedAge = age),
                )).toList(),
              ),

              const SizedBox(height: 48),

              // CTA
              GradientButton(
                label: AppStrings.startExploring,
                icon: Icons.explore_rounded,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
