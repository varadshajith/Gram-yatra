import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../widgets/gradient_button.dart';
import '../widgets/app_image.dart';

/// Screen 2: Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
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

              // Hero image area
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const AppImage('assets/images/Loginpage.jpeg'),
                    Container(
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: Text('🛕', style: TextStyle(fontSize: 60, color: Colors.white.withValues(alpha: 0.3))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            AppStrings.appName,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppStrings.tagline,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.primaryFixedDim,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Title
              Text(
                AppStrings.loginTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.loginSubtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 32),

              // Phone input
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: AppStrings.phoneHint,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 20, right: 8),
                    child: Text('🇮🇳 +91', style: TextStyle(fontSize: 16)),
                  ),
                  prefixIconConstraints: const BoxConstraints(minWidth: 0),
                ),
              ),

              const SizedBox(height: 20),

              // Send OTP
              GradientButton(
                label: AppStrings.sendOtp,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/profile-setup');
                },
              ),

              const SizedBox(height: 24),

              // Divider text
              Row(
                children: [
                  Expanded(child: Divider(color: AppTheme.outlineVariant.withValues(alpha: 0.3))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppTheme.outlineVariant.withValues(alpha: 0.3))),
                ],
              ),

              const SizedBox(height: 24),

              // Google login
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/profile-setup');
                  },
                  icon: const Text('G', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  label: Text(AppStrings.continueGoogle),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.onSurface,
                    side: BorderSide(color: AppTheme.outlineVariant.withValues(alpha: 0.3)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Guest
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Text(
                    AppStrings.continueGuest,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Data safe notice
              Center(
                child: Text(
                  AppStrings.dataSafe,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
