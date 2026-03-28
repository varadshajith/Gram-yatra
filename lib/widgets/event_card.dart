import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../widgets/app_image.dart';
import 'scale_tap.dart';

/// Card for events and festivals.
class EventCard extends StatelessWidget {
  final String icon;
  final String name;
  final String timeOrDate;
  final String description;
  final String? highlight;
  final VoidCallback? onTap;

  const EventCard({
    super.key,
    required this.icon,
    required this.name,
    required this.timeOrDate,
    required this.description,
    this.highlight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onTap: onTap,
      pressedScale: 0.97,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingSmall),
        decoration: BoxDecoration(
          color: const Color(0xFFF2E8D5),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: AppImage(icon),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: const Color(0xFF1A0A2E),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryContainer.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                        ),
                        child: Text(
                          timeOrDate,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.secondary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppTheme.spacingSmall),

            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF7B2D8B),
              ),
            ),

            if (highlight != null) ...[
              const SizedBox(height: AppTheme.spacingSmall),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryContainer.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppTheme.secondary.withValues(alpha: 0.3)),
                ),
                child: Text(
                  highlight!.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.secondary,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
