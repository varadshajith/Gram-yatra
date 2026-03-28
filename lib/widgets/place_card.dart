import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../widgets/app_image.dart';
import 'scale_tap.dart';

/// Reusable card for places, cuisines, businesses.
class PlaceCard extends StatelessWidget {
  final String emoji;
  final String name;
  final String description;
  final String? rating;
  final String? trailing;
  final VoidCallback? onTap;
  final Widget? action;

  const PlaceCard({
    super.key,
    required this.emoji,
    required this.name,
    required this.description,
    this.rating,
    this.trailing,
    this.onTap,
    this.action,
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
        child: Row(
          children: [
            // Custom AppImage for PlaceCard
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: AppImage(emoji), // Reusing 'emoji' parameter for asset path temporarily
            ),
            const SizedBox(width: 16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      color: const Color(0xFF1A0A2E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF7B2D8B),
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (rating != null) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 16, color: AppTheme.secondary),
                        const SizedBox(width: 4),
                        Text(
                          rating!,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: AppTheme.secondary,
                          ),
                        ),
                        if (trailing != null) ...[
                          const SizedBox(width: 12),
                          Text(
                            trailing!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 12,
                              color: const Color(0xFF7B2D8B),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Optional action
            ?action,

            // Arrow
            if (onTap != null && action == null)
              const Icon(Icons.chevron_right_rounded, color: AppTheme.outline),
          ],
        ),
      ),
    );
  }
}
