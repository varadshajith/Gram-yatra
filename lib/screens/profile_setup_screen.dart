import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../widgets/gradient_button.dart';
import '../widgets/category_chip.dart';
import '../main.dart';

/// Screen 3: Profile Setup / Returning User
class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  final Set<String> _selectedPrefs = {};
  String? _selectedHomeArea;
  String? _selectedTravelStyle;

  final _preferences = [
    AppStrings.pilgrimage,
    AppStrings.nature,
    AppStrings.food,
    AppStrings.art,
    AppStrings.shopping,
  ];

  final _homeAreas = [
    'Panchavati',
    'College Road',
    'CIDCO',
    'Satpur',
    'Nashik Road',
    'Other/Visitor'
  ];

  final _travelStyles = ['Relaxed', 'Fast-paced', 'Balanced'];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfileAndContinue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasProfile', true);
    await prefs.setString('userName', _nameController.text.trim());
    await prefs.setStringList('userInterests', _selectedPrefs.toList());
    if (_selectedHomeArea != null) {
      await prefs.setString('userHomeArea', _selectedHomeArea!);
    }
    if (_selectedTravelStyle != null) {
      await prefs.setString('userTravelStyle', _selectedTravelStyle!);
    }

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/home');
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

              // Home Area
              Text(
                'Home Area in Nashik',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _homeAreas.map((area) => CategoryChip(
                  label: area,
                  isSelected: _selectedHomeArea == area,
                  onTap: () => setState(() => _selectedHomeArea = area),
                )).toList(),
              ),

              const SizedBox(height: 32),

              // Travel Style
              Text(
                'Travel Style',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _travelStyles.map((style) => CategoryChip(
                  label: style,
                  isSelected: _selectedTravelStyle == style,
                  onTap: () => setState(() => _selectedTravelStyle = style),
                )).toList(),
              ),

              const SizedBox(height: 32),

              // Dark Mode Toggle
               ValueListenableBuilder<ThemeMode>(
                 valueListenable: themeNotifier,
                 builder: (context, mode, child) {
                   return SwitchListTile(
                     contentPadding: EdgeInsets.zero,
                     title: Text(
                       'Dark Mode',
                       style: Theme.of(context).textTheme.titleMedium,
                     ),
                     value: mode == ThemeMode.dark,
                     onChanged: (val) {
                       themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
                     },
                     activeTrackColor: AppTheme.primary.withValues(alpha: 0.5),
                     activeThumbColor: AppTheme.primary,
                   );
                 },
               ),

              const SizedBox(height: 32),

              // CTA
              GradientButton(
                label: AppStrings.startExploring,
                icon: Icons.explore_rounded,
                onPressed: _saveProfileAndContinue,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
