# skills/flutter-ui.md — Flutter UI Guide (Tanvi)
> Read CLAUDE.md and AGENTS.md first.

## Your Job
Convert Stitch mockups → Flutter screens. Build reusable widgets. Define app theme.

## App Theme (create this first)
`lib/utils/theme.dart`
```dart
import 'package:flutter/material.dart';

class AppTheme {
  // Gram Yatra colors
  static const Color primary = Color(0xFF8B4513);      // Saffron brown
  static const Color accent = Color(0xFFFF6B35);       // Nashik orange
  static const Color background = Color(0xFFFFF8F0);   // Warm cream
  static const Color textDark = Color(0xFF2C1810);
  static const Color safeGreen = Color(0xFF4CAF50);
  static const Color dangerRed = Color(0xFFE53935);

  static ThemeData get theme => ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: background,
    fontFamily: 'Poppins',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
  );
}
```

## Screen Template
```dart
import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // your widgets here
          ],
        ),
      ),
    );
  }
}
```

## Reusable Widgets to Build
Create these in `lib/widgets/`:
- `poi_card.dart` — card for a place of interest
- `plan_card.dart` — card showing one AI-generated plan
- `sos_button.dart` — big red SOS button
- `category_chip.dart` — filter chip for map categories

## Strings File
`lib/utils/strings.dart`
```dart
class AppStrings {
  static const String appName = 'Gram Yatra';
  static const String welcomeTagline = 'Nashik, the way locals see it.';
  static const String planBuilderTitle = 'Build Your Day';
  static const String sosButtonLabel = 'SOS Emergency';
  static const String kumbhTitle = 'Kumbh Survival Guide';
  // add more as needed
}
```

## DO NOT
- No Firebase calls in screen files
- No hardcoded hex colors — use AppTheme
- No hardcoded strings — use AppStrings
- Mock data is fine for now — leave `// TODO: wire to real data`
