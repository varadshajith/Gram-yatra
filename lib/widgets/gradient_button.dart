import 'package:flutter/material.dart';
import '../utils/theme.dart';
import 'scale_tap.dart';

/// Oval gradient CTA button following the Modern Pilgrim design system.
/// Uses primary→primaryContainer 45° gradient.
class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final IconData? icon;

  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onPressed,
      pressedScale: 0.96,
      child: Container(
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(14),
            splashColor: AppTheme.onPrimary.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: AppTheme.onPrimary, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
