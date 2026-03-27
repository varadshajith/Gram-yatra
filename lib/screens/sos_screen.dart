import 'package:flutter/material.dart';
import '../utils/theme.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final helplines = [
      {'name': 'Police', 'number': '100', 'icon': Icons.local_police},
      {'name': 'Ambulance', 'number': '108', 'icon': Icons.local_hospital},
      {'name': 'Women Helpline', 'number': '1091', 'icon': Icons.pregnant_woman},
      {'name': 'Tourist Helpline', 'number': '1363', 'icon': Icons.tour},
      {'name': 'Nashik Municipal', 'number': '0253-2222222', 'icon': Icons.location_city},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS & Helplines'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background for app.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.55),
            ),
          ),
          ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: helplines.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final h = helplines[index];
              return Card(
                color: AppTheme.surfaceContainerLowest.withValues(alpha: 0.9),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryFixedDim.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(h['icon'] as IconData, color: Colors.red),
                  ),
                  title: Text(
                    h['name'] as String,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    h['number'] as String,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  trailing: const Icon(Icons.call, color: AppTheme.primary),
                  onTap: () {},
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
