import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../widgets/app_image.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingSmall),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          boxShadow: AppTheme.ambientShadow,
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
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.onSurfaceVariant,
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
                              color: AppTheme.onSurfaceVariant,
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
