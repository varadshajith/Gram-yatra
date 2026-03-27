import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../utils/constants.dart';
import '../widgets/app_image.dart';

/// Screen 13: Traveler Experience Blog / Feed
class TravelerExperienceScreen extends StatelessWidget {
  const TravelerExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.travelerExpTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          boxShadow: AppTheme.ambientShadow,
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Share your story feature coming soon!'),
                backgroundColor: AppTheme.primary,
              ),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: const Icon(Icons.add_a_photo_rounded, color: Colors.white),
          label: Text(
            AppStrings.shareStory,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            Text(
              'Stories from fellow travelers',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 24),

            // Filter row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(label: 'Recent', selected: true),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'Popular', selected: false),
                  const SizedBox(width: 8),
                  _FilterChip(label: '📷 Photos', selected: false),
                  const SizedBox(width: 8),
                  _FilterChip(label: '🎥 Videos', selected: false),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Traveler posts
            ...MockData.travelerPosts.map((post) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _TravelerPost(post: post),
            )),

            const SizedBox(height: 80), // FAB clearance
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _FilterChip({required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? AppTheme.primaryFixedDim : AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 12,
          color: selected ? AppTheme.primary : AppTheme.onSurfaceVariant,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}

class _TravelerPost extends StatelessWidget {
  final Map<String, String> post;

  const _TravelerPost({required this.post});

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
          // User header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppTheme.surfaceContainerHigh,
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                child: AppImage(post['avatar']!),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post['user']!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      post['time']!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (post['type'] == 'video')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.play_circle_filled, size: 14, color: AppTheme.secondary),
                      const SizedBox(width: 4),
                      Text(
                        'Video',
                        style: TextStyle(fontSize: 10, color: AppTheme.secondary, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // Image placeholder with Shimmer fallback
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  post['image']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(color: const Color(0xFF7B2D8B)),
                ),
                if (post['type'] == 'video')
                  const Center(
                    child: Icon(Icons.play_circle_outline, size: 48, color: Colors.white70),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Caption
          Text(
            post['caption']!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),

          const SizedBox(height: 12),

          // Likes
          Row(
            children: [
              const Icon(Icons.favorite_rounded, size: 18, color: AppTheme.primary),
              const SizedBox(width: 6),
              Text(
                '${post['likes']} likes',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              const Icon(Icons.share_rounded, size: 18, color: AppTheme.onSurfaceVariant),
            ],
          ),
        ],
      ),
    );
  }
}
