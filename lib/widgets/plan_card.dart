import 'package:flutter/material.dart';
import '../utils/theme.dart';

/// AI plan result card with name, tagline, stops, cost, and CTA.
class PlanCard extends StatelessWidget {
  final String name;
  final String tagline;
  final List<String> stops;
  final String estimatedCost;
  final String highlights;
  final String duration;
  final VoidCallback? onStart;

  const PlanCard({
    super.key,
    required this.name,
    required this.tagline,
    required this.stops,
    required this.estimatedCost,
    required this.highlights,
    required this.duration,
    this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.ambientShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(tagline, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.onSurfaceVariant,
          )),

          const SizedBox(height: AppTheme.spacingMedium),

          // Stops timeline
          ...stops.asMap().entries.map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryFixedDim,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${entry.key + 1}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.primary,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(entry.value, style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          )),

          const SizedBox(height: AppTheme.spacingSmall),

          // Info chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _InfoChip(icon: Icons.schedule, label: duration),
              _InfoChip(icon: Icons.currency_rupee, label: estimatedCost),
            ],
          ),

          const SizedBox(height: AppTheme.spacingSmall),

          // Highlights
          Text(
            highlights,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: AppTheme.spacingMedium),

          // CTA
          if (onStart != null)
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onStart,
                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Center(
                        child: Text(
                          'Start This Plan',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 12,
            color: AppTheme.onSurfaceVariant,
          )),
        ],
      ),
    );
  }
}
