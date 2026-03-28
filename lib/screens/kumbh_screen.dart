import 'package:flutter/material.dart';

class KumbhScreen extends StatelessWidget {
  const KumbhScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text('Kumbh Mela 2027'),
        backgroundColor: Colors.orange.shade800,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Header Image or Emblem Box
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade600, Colors.deepOrange.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                Icon(Icons.water_drop, size: 48, color: Colors.indigo),
                SizedBox(height: 12),
                Text(
                  'Nashik Kumbh Mela',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The greatest spiritual gathering on Earth returns to the banks of the mighty Godavari.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),

          const Text(
            'Important Ghats',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            Icons.location_on,
            'Ramkund Ghat',
            'The holiest ghat in Nashik where Lord Surya is believed to have bathed. It is the primary site for the Shahi Snan.',
          ),
          _buildInfoCard(
            Icons.location_on,
            'Kushavarta Tirtha',
            'Located in Trimbakeshwar, this sacred pond is where the Godavari river takes its course. The Naga Sadhus exclusively bathe here.',
          ),

          const SizedBox(height: 32),

          const Text(
            'Key Snan (Bathing) Dates',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          const SizedBox(height: 12),
          _buildDateCard('14 July 2027', 'Makar Sankranti & First Snan'),
          _buildDateCard('18 August 2027', 'Shravan Amavasya'),
          _buildDateCard('13 September 2027', 'Main Shahi Snan (Royal Bath)'),
          _buildDateCard('15 October 2027', 'Final Snan (Closing)'),

          const SizedBox(height: 32),

          const Text(
            'Guidelines & Facilities',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          const SizedBox(height: 12),
          _buildInfoCard(Icons.health_and_safety, 'Medical Centers', '24/7 emergency centers and ambulance routing dedicated across the Godavari belt.'),
          _buildInfoCard(Icons.wc, 'Sanitation', 'Over 10,000 mobile toilets and pure drinking water stations available.'),
          _buildInfoCard(Icons.directions_bus, 'Free Transport', 'Nashik Municipal Corporation hosts 500+ free shuttle buses from parking hubs to the Ghats.'),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String desc) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.orange.shade100,
          child: Icon(icon, color: Colors.orange.shade800),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(desc, style: TextStyle(color: Colors.grey.shade700)),
        ),
      ),
    );
  }

  Widget _buildDateCard(String date, String event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        border: Border(left: BorderSide(color: Colors.indigo.shade400, width: 4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo.shade900)),
          Flexible(
            child: Text(
              event, 
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.indigo.shade700),
            ),
          ),
        ],
      ),
    );
  }
}
