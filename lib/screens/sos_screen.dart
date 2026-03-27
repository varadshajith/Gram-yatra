import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/theme.dart';

class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  Future<void> _confirmAndLaunch(BuildContext context, String title, String content, String urlStr) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, foregroundColor: Colors.white),
            onPressed: () async {
              Navigator.pop(ctx);
              final url = Uri.parse(urlStr);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.message, color: Colors.green),
            tooltip: 'WhatsApp Police Platform',
            onPressed: () => _confirmAndLaunch(
              context,
              'Open WhatsApp',
              'This will open a direct chat with the Nashik Police Helpline (1091).',
              'https://wa.me/911091',
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: helplines.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final h = helplines[index];
          return Card(
            color: AppTheme.surfaceContainerLowest,
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red.shade700,
        icon: const Icon(Icons.emergency, color: Colors.white),
        label: const Text('SOS 112', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        onPressed: () => _confirmAndLaunch(
          context,
          'Emergency Protocol',
          'Are you sure you want to dial emergency services (112)?',
          'tel:112',
        ),
      ),
    );
  }
}
