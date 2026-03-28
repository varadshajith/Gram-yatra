import 'package:flutter/material.dart';
import '../services/gemini_services.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final _gemini = GeminiDirectService();

  // User inputs
  int _hours = 4;
  int _budget = 500;
  String _groupType = 'Friends';
  String _crowdLevel = 'low';
  final List<String> _selectedPrefs = ['Nature'];

  // State
  bool _loading = false;
  List<Map<String, dynamic>> _plan = [];
  String _error = '';

  final _preferences = ['Nature', 'Pilgrimage', 'Food', 'Adventure'];
  final _groupTypes = ['Solo', 'Friends', 'Family', 'Couple'];
  final _crowdLevels = ['low', 'medium', 'high'];

  Future<void> _generatePlan() async {
    setState(() {
      _loading = true;
      _error = '';
      _plan = [];
    });

    final result = await _gemini.generatePlan(
      hours: _hours,
      budget: _budget,
      preferences: _selectedPrefs.join(', '),
      groupType: _groupType,
      crowdLevel: _crowdLevel,
      lat: 20.0059,
      lng: 73.7898,
    );

    setState(() {
      _loading = false;
      if (result.isEmpty) {
        _error = 'Could not generate plan. Check your API key and internet.';
      } else {
        _plan = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Trip Planner'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hours slider
            const Text(
              'Available Time (hours)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _hours.toDouble(),
              min: 1,
              max: 12,
              divisions: 11,
              label: '$_hours hrs',
              activeColor: Colors.orange,
              onChanged: (v) => setState(() => _hours = v.toInt()),
            ),
            Text('$_hours hours selected'),

            const SizedBox(height: 16),

            // Budget slider
            const Text(
              'Budget (₹)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _budget.toDouble(),
              min: 100,
              max: 5000,
              divisions: 49,
              label: '₹$_budget',
              activeColor: Colors.orange,
              onChanged: (v) => setState(() => _budget = v.toInt()),
            ),
            Text('₹$_budget budget'),

            const SizedBox(height: 16),

            // Preferences
            const Text(
              'Preferences',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: _preferences.map((pref) {
                final selected = _selectedPrefs.contains(pref);
                return FilterChip(
                  label: Text(pref),
                  selected: selected,
                  selectedColor: Colors.orange.shade200,
                  onSelected: (val) {
                    setState(() {
                      if (val) {
                        _selectedPrefs.add(pref);
                      } else {
                        _selectedPrefs.remove(pref);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Group type
            const Text(
              'Group Type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: _groupTypes.map((type) {
                return ChoiceChip(
                  label: Text(type),
                  selected: _groupType == type,
                  selectedColor: Colors.orange.shade200,
                  onSelected: (_) => setState(() => _groupType = type),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Crowd tolerance
            const Text(
              'Crowd Tolerance',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children: _crowdLevels.map((level) {
                return ChoiceChip(
                  label: Text(level),
                  selected: _crowdLevel == level,
                  selectedColor: Colors.orange.shade200,
                  onSelected: (_) => setState(() => _crowdLevel = level),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Generate button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _loading ? null : _generatePlan,
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Generate My Plan',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),

            const SizedBox(height: 24),

            // Error
            if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red)),

            // Results
            if (_plan.isNotEmpty) ...[
              const Text(
                'Your Nashik Plan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ..._plan.asMap().entries.map((entry) {
                final i = entry.key;
                final stop = entry.value;
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.orange,
                              child: Text(
                                '${i + 1}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                stop['place'] ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(stop['duration'] ?? ''),
                            const SizedBox(width: 16),
                            const Icon(
                              Icons.currency_rupee,
                              size: 16,
                              color: Colors.grey,
                            ),
                            Text('${stop['cost'] ?? 0}'),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule,
                              size: 16,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 4),
                            Expanded(child: Text(stop['best_time'] ?? '')),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.lightbulb,
                              size: 16,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 4),
                            Expanded(child: Text(stop['tip'] ?? '')),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }
}
