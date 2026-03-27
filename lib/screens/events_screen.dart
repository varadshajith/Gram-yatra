import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/strings.dart';
import '../utils/constants.dart';
import '../widgets/section_header.dart';
import '../widgets/event_card.dart';

/// Screen 14: Events in Nashik
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(AppStrings.eventsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month_rounded),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: AppTheme.primary,
                        onPrimary: Colors.white,
                        surface: AppTheme.surfaceContainerLowest,
                        onSurface: AppTheme.onSurface,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (date != null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Events for ${date.day}/${date.month}/${date.year} coming soon'),
                    backgroundColor: AppTheme.primary,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Godaarti.jpeg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFF1A0A2E)),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.55),
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  Text(
                    'Never miss what\'s happening in Nashik',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Daily events
                  const SectionHeader(title: 'Daily Events'),

                  ...MockData.dailyEvents.map((event) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: EventCard(
                      icon: event['icon']!,
                      name: event['name']!,
                      timeOrDate: event['time']!,
                      description: event['desc']!,
                    ),
                  )),

                  const SizedBox(height: 28),

                  // Upcoming events
                  const SectionHeader(title: 'Upcoming'),

                  ...MockData.upcomingEvents.map((event) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: EventCard(
                      icon: event['icon']!,
                      name: event['name']!,
                      timeOrDate: event['date']!,
                      description: event['desc']!,
                    ),
                  )),

                  const SizedBox(height: 28),

                  // Add to calendar CTA
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.notifications_active_rounded, color: AppTheme.primary),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Get Event Alerts',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Never miss Goda Arti or local exhibitions',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
