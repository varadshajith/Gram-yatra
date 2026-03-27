import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../widgets/gradient_button.dart';

/// Screen 1: Cinematic Welcome Splash
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient simulating cinematic Nashik scenery
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6B1A33), // primaryContainer
                  Color(0xFF4E021E), // primary
                  Color(0xFF2A0610), // deep burgundy
                ],
              ),
            ),
          ),

          // Decorative circles for visual depth
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.secondary.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            bottom: 160,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryFixedDim.withValues(alpha: 0.06),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // Landmark emojis
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LandmarkIcon(emoji: '🛕', delay: 0),
                      const SizedBox(width: 20),
                      _LandmarkIcon(emoji: '🍇', delay: 100),
                      const SizedBox(width: 20),
                      _LandmarkIcon(emoji: '⛰️', delay: 200),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // App name
                  Text(
                    AppStrings.appName,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Tagline
                  Text(
                    AppStrings.tagline,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.primaryFixedDim,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    AppStrings.taglineSub,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primaryFixedDim.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(flex: 3),

                  // CTA Button
                  GradientButton(
                    label: AppStrings.beginJourney,
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LandmarkIcon extends StatelessWidget {
  final String emoji;
  final int delay;

  const _LandmarkIcon({required this.emoji, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Center(
        child: Text(emoji, style: const TextStyle(fontSize: 36)),
      ),
    );
  }
}
