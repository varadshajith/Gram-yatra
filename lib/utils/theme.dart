import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Gram Yatra — "The Modern Pilgrim" Design System
/// Burgundy for heritage, Saffron for the divine, Earthy Green for the landscape.
class AppTheme {
  // ─── Primary Colors ───
  static const Color primary = Color(0xFF4E021E);
  static const Color primaryContainer = Color(0xFF6B1A33);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFFEE829B);

  // ─── Secondary (Saffron) ───
  static const Color secondary = Color(0xFF9D4400);
  static const Color secondaryContainer = Color(0xFFFE7F2F);
  static const Color onSecondary = Color(0xFFFFFFFF);

  // ─── Tertiary (Earthy Green) ───
  static const Color tertiary = Color(0xFF002B0E);
  static const Color tertiaryContainer = Color(0xFF00431A);
  static const Color onTertiary = Color(0xFFFFFFFF);

  // ─── Surfaces (No-Line Rule: boundaries via tonal shifts) ───
  static const Color surface = Color(0xFFFAF9F9);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF5F3F3);
  static const Color surfaceContainer = Color(0xFFEFEDED);
  static const Color surfaceContainerHigh = Color(0xFFE9E8E8);
  static const Color surfaceContainerHighest = Color(0xFFE3E2E2);
  static const Color surfaceDim = Color(0xFFDBDAD9);

  // ─── On-Surface ───
  static const Color onSurface = Color(0xFF1B1C1C);
  static const Color onSurfaceVariant = Color(0xFF544245);
  static const Color outline = Color(0xFF877275);
  static const Color outlineVariant = Color(0xFFDAC0C4);

  // ─── Fixed & Accents ───
  static const Color primaryFixed = Color(0xFFFFD9DF);
  static const Color primaryFixedDim = Color(0xFFFFB1C0);
  static const Color inversePrimary = Color(0xFFFFB1C0);
  static const Color inverseSurface = Color(0xFF303031);

  // ─── Error ───
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);

  // ─── Spacing Scale (Mathematical Harmony) ───
  static const double spacingMicro = 6;    // 0.375rem
  static const double spacingSmall = 12;   // 0.75rem
  static const double spacingMedium = 24;  // 1.5rem
  static const double spacingLarge = 40;   // 2.5rem

  // ─── Corner Radii ───
  static const double radiusMd = 24;   // 1.5rem — cards
  static const double radiusFull = 50; // full pill — buttons/nav

  // ─── Gradient (Burgundy gradient for CTAs) ───
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryContainer],
  );

  // ─── Ambient Shadow (tinted, never pure black) ───
  static List<BoxShadow> ambientShadow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.08),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  // ─── Glassmorphism Decoration ───
  static BoxDecoration glassmorphism = BoxDecoration(
    color: surface.withValues(alpha: 0.80),
    borderRadius: BorderRadius.circular(radiusFull),
    border: Border.all(
      color: outlineVariant.withValues(alpha: 0.15),
    ),
  );

  // ─── Theme Data ───
  static ThemeData get theme {
    final textTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: surface,
      colorScheme: const ColorScheme.light(
        primary: primary,
        primaryContainer: primaryContainer,
        onPrimary: onPrimary,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        secondaryContainer: secondaryContainer,
        onSecondary: onSecondary,
        tertiary: tertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiary: onTertiary,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        error: error,
        onError: onError,
        inversePrimary: inversePrimary,
        inverseSurface: inverseSurface,
      ),
      textTheme: textTheme.copyWith(
        displaySmall: textTheme.displaySmall?.copyWith(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.32,
          color: primary,
        ),
        headlineSmall: textTheme.headlineSmall?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.16,
          color: onSurface,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: primary,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          fontSize: 16,
          color: onSurface,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          color: onSurface,
        ),
        labelSmall: textTheme.labelSmall?.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.28,
          color: onSurfaceVariant,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          elevation: 0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusFull),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusFull),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusFull),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceContainerLow,
        selectedColor: primaryFixedDim,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull),
        ),
        side: BorderSide.none,
        labelStyle: textTheme.bodyMedium?.copyWith(color: onSurface),
      ),
      cardTheme: CardThemeData(
        color: surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        margin: EdgeInsets.zero,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: primary,
        unselectedItemColor: onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: primary,
        ),
      ),
    );
  }
}
