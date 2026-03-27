import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/theme.dart';
import '../widgets/place_card.dart';
import '../utils/constants.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String _userName = 'Traveler';
  List<String> _interests = [];
  String _homeArea = '';
  String _travelStyle = '';
  List<Map<String, dynamic>> _savedPlaces = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load saved places IDs and map them to actual mock data places
    final savedPlacesIds = prefs.getStringList('savedPlaces') ?? [];
    
    // Find matching places in mock data
    final List<Map<String, dynamic>> loadedPlaces = [];
    final allPlaces = [
      ...MockData.topAttractions,
      ...MockData.topCuisine,
    ];
    
    for (var id in savedPlacesIds) {
      final place = allPlaces.where((p) => p['name'] == id).firstOrNull;
      if (place != null) {
        loadedPlaces.add(place);
      }
    }

    setState(() {
      _userName = prefs.getString('userName') ?? 'Traveler';
      _interests = prefs.getStringList('userInterests') ?? [];
      _homeArea = prefs.getString('userHomeArea') ?? '';
      _travelStyle = prefs.getString('userTravelStyle') ?? '';
      _savedPlaces = loadedPlaces;
      _isLoading = false;
    });
  }

  Future<void> _editName() async {
    final nameController = TextEditingController(text: _userName);
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Name'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: 'Enter your name'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, nameController.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (newName != null && newName.trim().isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', newName.trim());
      setState(() {
        _userName = newName.trim();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editName,
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Welcomepage.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.55),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppTheme.primaryContainer,
                    child: Text(
                      _userName.isNotEmpty ? _userName[0].toUpperCase() : '?',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    _userName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                Text(
                  'Travel Preferences',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                
                if (_homeArea.isNotEmpty) ...[
                  Text(
                    'Home Area: $_homeArea',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                
                if (_travelStyle.isNotEmpty) ...[
                  Text(
                    'Travel Style: $_travelStyle',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                
                if (_interests.isNotEmpty) ...[
                  Text(
                    'Interests:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _interests.map((interest) => Chip(
                      label: Text(interest),
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      side: BorderSide.none,
                      labelStyle: const TextStyle(color: Colors.white70),
                    )).toList(),
                  ),
                ],

                const SizedBox(height: 32),
                Text(
                  'Saved Places',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                
                if (_savedPlaces.isEmpty)
                  const Text(
                    'No saved places yet. Start exploring and bookmark your favorites!',
                    style: TextStyle(color: Colors.white70),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _savedPlaces.length,
                    itemBuilder: (context, index) {
                      final place = _savedPlaces[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: PlaceCard(
                          emoji: place['image'] ?? place['icon'] ?? 'assets/images/placeholder.jpeg',
                          name: place['name']!,
                          description: place['description'] ?? place['type'] ?? '',
                          rating: place['rating'],
                          onTap: () => Navigator.pushNamed(context, '/place-detail', arguments: place),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
