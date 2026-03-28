import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Login Screen — Sacred Vine themed sign-in page
/// Matches profile_setup_screen.dart background + chip styling exactly.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // ─── Sacred Vine Theme Colors ───
  static const Color _nightSky = Color(0xFF1A0A2E);
  static const Color _templePurple = Color(0xFF7B2D8B);
  static const Color _sandstoneCream = Color(0xFFF2E8D5);

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ─── Background: same image as profile setup screen ───
          Positioned.fill(
            child: Image.asset(
              'assets/images/Loginpage.jpeg',
              fit: BoxFit.cover,
            ),
          ),

          // ─── Dark gradient overlay ───
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xAA1A0A2E),
                    Color(0xCC1A0A2E),
                  ],
                ),
              ),
            ),
          ),

          // ─── Content ───
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 48),

                    // ─── App Title ───
                    Text(
                      'Gram Yatra',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: _sandstoneCream,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // ─── Subtitle ───
                    Text(
                      'THE CHRONICLER OF HERITAGE',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3.0,
                        color: _sandstoneCream.withValues(alpha: 0.6),
                      ),
                    ),

                    const SizedBox(height: 48),

                    // ─── Welcome Heading ───
                    Text(
                      'Welcome to the Journey',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // ─── Sign-in subtitle ───
                    Text(
                      'Sign in to begin your spiritual exploration',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),

                    const SizedBox(height: 36),

                    // ─── Continue with Google ───
                    _LoginChipButton(
                      label: 'Continue with Google',
                      icon: _buildGoogleIcon(),
                      onTap: () => _navigateToHome(context),
                    ),

                    const SizedBox(height: 14),

                    // ─── Sign in with Phone ───
                    _LoginChipButton(
                      label: 'Sign in with Phone',
                      icon: const Icon(Icons.phone_android,
                          color: Colors.white, size: 18),
                      onTap: () => _navigateToHome(context),
                    ),

                    const SizedBox(height: 20),

                    // ─── OR Divider ───
                    Text(
                      'OR',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ─── Use Email Address ───
                    _LoginChipButton(
                      label: 'Use Email Address',
                      icon: const Icon(Icons.email_outlined,
                          color: Colors.white, size: 18),
                      onTap: () => _navigateToHome(context),
                    ),

                    const SizedBox(height: 24),

                    // ─── Legal Text ───
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'By continuing, you agree to the Terms of Service and Privacy Policy',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // ─── Divider Line ───
                    Container(
                      width: 60,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ─── Inspirational Quote ───
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '\u201CThe journey of a thousand miles begins with a single step towards the sacred.\u201D',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: _sandstoneCream,
                          height: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ─── Location Badge ───
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on,
                            color: _templePurple, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'NASHIK, INDIA',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.0,
                            color: _templePurple,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ─── Continue Exploring Button ───
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _navigateToHome(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _templePurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Continue Exploring \u2192',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a simple Google "G" icon with brand blue
  Widget _buildGoogleIcon() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        'G',
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF4285F4),
        ),
      ),
    );
  }
}

/// Login button styled like profile-setup CategoryChip:
/// semi-transparent dark fill, white text, pill shape.
class _LoginChipButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const _LoginChipButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          // Same semi-transparent fill as CategoryChip unselected state
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
