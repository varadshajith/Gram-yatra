/// Mock data constants for all screens.
/// TODO: wire to real Firestore data
class MockData {
  // ─── Top 5 Attractions ───
  static const List<Map<String, String>> topAttractions = [
    {
      'name': 'Panchavati Ramkund',
      'description': 'Sacred bathing ghat on the Godavari river where Lord Rama is believed to have bathed during exile. A spiritual landmark of Nashik.',
      'category': 'temple',
      'image': 'assets/images/PanchavatiRamkund.jpeg',
      'rating': '4.8',
    },
    {
      'name': 'Sula Vineyards',
      'description': 'India\'s most celebrated vineyard offering wine tours, tastings, and stunning valley views. The crown jewel of Nashik\'s wine country.',
      'category': 'hidden_gem',
      'image': 'assets/images/Sulawines.jpeg',
      'rating': '4.7',
    },
    {
      'name': 'Anjaneri Hills',
      'description': 'Birthplace of Lord Hanuman with a challenging trek trail offering panoramic views of Nashik and surrounding valleys.',
      'category': 'nature',
      'image': 'assets/images/Harishchandragad.jpeg',
      'rating': '4.6',
    },
    {
      'name': 'Trimbakeshwar Temple',
      'description': 'One of the twelve Jyotirlingas of Lord Shiva, located at the source of the Godavari river. A must-visit pilgrimage destination.',
      'category': 'temple',
      'image': 'assets/images/Trimabakeshkar.jpeg',
      'rating': '4.9',
    },
    {
      'name': 'Saptashrungi Devi Temple',
      'description': 'Ancient temple of Goddess Saptashrungi perched on a hilltop, surrounded by lush greenery and 108 sacred steps.',
      'category': 'temple',
      'image': 'assets/images/Saptrashungigad.jpeg',
      'rating': '4.7',
    },
  ];

  // ─── Top 5 Cuisine ───
  static const List<Map<String, String>> topCuisine = [
    {'name': 'Sadhana Misal', 'type': 'Misal', 'rating': '4.9', 'icon': 'assets/images/Misal.jpeg'},
    {'name': 'Samarth Juice', 'type': 'Drinks', 'rating': '4.7', 'icon': 'assets/images/Samarthajuice.jpeg'},
    {'name': 'Buda Halwai', 'type': 'Sweets', 'rating': '4.8', 'icon': 'assets/images/Budhahalwai.jpeg'},
    {'name': 'Sainzara Vadaj', 'type': 'Snacks', 'rating': '4.6', 'icon': 'assets/images/Misal.jpeg'},
    {'name': 'Jotka Misal', 'type': 'Misal', 'rating': '4.8', 'icon': 'assets/images/Misal.jpeg'},
  ];

  static const List<String> cuisineCategories = ['All', 'Misal', 'Sweets', 'Drinks', 'Snacks'];

  // ─── Local Business Categories ───
  static const List<Map<String, String>> businessCategories = [
    {'name': 'Architecture', 'icon': 'assets/images/arhitecture.jpeg', 'count': '12'},
    {'name': 'Agriculture', 'icon': 'assets/images/Agriculture.jpeg', 'count': '18'},
    {'name': 'Manufacturing', 'icon': 'assets/images/taparia.jpeg', 'count': '9'},
    {'name': 'Tourism Services', 'icon': 'assets/images/tourisms.jpeg', 'count': '15'},
    {'name': 'Traditional Fashion', 'icon': 'assets/images/traditionalfashion.jpeg', 'count': '11'},
  ];

  // Businesses by category
  static const Map<String, List<Map<String, String>>> businesses = {
    'Agriculture': [
      {'name': 'Sahyadri Farms', 'desc': 'Largest grape exporter in India', 'rating': '4.8'},
      {'name': 'Boras Agro', 'desc': 'Organic farming solutions', 'rating': '4.5'},
      {'name': 'Nashik Grape Valley', 'desc': 'Premium grape cultivation', 'rating': '4.6'},
    ],
    'Manufacturing': [
      {'name': 'HAL Nashik', 'desc': 'Hindustan Aeronautics Division', 'rating': '4.9'},
      {'name': 'India Security Press', 'desc': 'Currency & stamp printing', 'rating': '4.7'},
      {'name': 'Mahindra Nashik Plant', 'desc': 'Vehicle manufacturing', 'rating': '4.5'},
    ],
    'Tourism Services': [
      {'name': 'Nashik Heritage Walks', 'desc': 'Guided cultural tours', 'rating': '4.8'},
      {'name': 'Godavari Boat Rides', 'desc': 'Scenic river experience', 'rating': '4.6'},
      {'name': 'Wine Tour Nashik', 'desc': 'Curated vineyard experiences', 'rating': '4.7'},
    ],
    'Traditional Fashion': [
      {'name': 'Paithani Saree Center', 'desc': 'Authentic Paithani weaves', 'rating': '4.9'},
      {'name': 'Nashik Kolhapuri House', 'desc': 'Handmade leather chappals', 'rating': '4.5'},
      {'name': 'Yeola Paithani Hub', 'desc': 'Traditional silk sarees', 'rating': '4.8'},
    ],
    'Architecture': [
      {'name': 'Pandavleni Caves', 'desc': '2000-year-old Buddhist rock-cut caves', 'rating': '4.7'},
      {'name': 'Coin Museum Nashik', 'desc': 'Historic numismatic collection', 'rating': '4.4'},
      {'name': 'Kalaram Temple Complex', 'desc': 'Black stone Ram temple, 18th century', 'rating': '4.8'},
    ],
  };

  // ─── Road Trips ───
  static const List<Map<String, String>> roadTrips = [
    {
      'name': 'Bhandardara',
      'distance': '70 km',
      'time': '2 hrs',
      'season': 'Monsoon (Jul–Sep)',
      'desc': 'Pristine lake surrounded by Sahyadri mountains. Famous for Arthur Lake, Randha Falls, and Wilson Dam.',
      'icon': 'assets/images/Bhandardara.jpeg',
    },
    {
      'name': 'Shirdi',
      'distance': '92 km',
      'time': '2.5 hrs',
      'season': 'Year-round',
      'desc': 'Home of Sai Baba temple, one of India\'s most visited pilgrimage destinations.',
      'icon': 'assets/images/Shirdi.jpeg',
    },
    {
      'name': 'Harishchandragad',
      'distance': '85 km',
      'time': '2.5 hrs',
      'season': 'Oct–Feb',
      'desc': 'Ancient hill fort with the famous Konkan Kada cliff and Kedareshwar cave temple.',
      'icon': 'assets/images/Harishchandragad.jpeg',
    },
  ];

  // ─── Events ───
  static const List<Map<String, String>> dailyEvents = [
    {
      'name': 'Goda Arti at Ramkund',
      'time': '5:30 AM Daily',
      'desc': 'Sacred morning aarti on the banks of Godavari river at Ramkund ghat.',
      'icon': 'assets/images/Godaarti.jpeg',
    },
    {
      'name': 'Evening Ganga Aarti',
      'time': '7:00 PM Daily',
      'desc': 'Beautiful lamp ceremony at Panchavati Ghats as the sun sets.',
      'icon': 'assets/images/Godaarti.jpeg',
    },
  ];

  static const List<Map<String, String>> upcomingEvents = [
    {
      'name': 'Nashik Art Exhibition',
      'date': 'April 5–10, 2026',
      'desc': 'Showcasing local and national artists at Nashik Art Gallery.',
      'icon': 'assets/images/tourisms.jpeg',
    },
    {
      'name': 'Wine & Dine Festival',
      'date': 'April 15–17, 2026',
      'desc': 'Annual wine tasting and food festival at Sula Vineyards.',
      'icon': 'assets/images/Sulawines.jpeg',
    },
    {
      'name': 'Godavari Mahotsav',
      'date': 'May 1–3, 2026',
      'desc': 'Cultural festival celebrating the Godavari river heritage.',
      'icon': 'assets/images/PanchavatiRamkund.jpeg',
    },
  ];

  // ─── Festivals ───
  static const List<Map<String, String>> festivals = [
    {
      'name': 'Rang Panchami',
      'date': 'March',
      'desc': 'Nashik\'s unique five-day color festival celebrated with immense energy and water colors across the old city.',
      'icon': 'assets/images/Rangapanchami.jpeg',
      'highlight': 'Color processions through Panchavati',
    },
    {
      'name': 'Gudi Padwa',
      'date': 'March / April',
      'desc': 'Maharashtrian New Year celebrated with the iconic Shobha Yatra procession through Nashik streets.',
      'icon': 'assets/images/Gudipadwa.jpeg',
      'highlight': 'Grand Shobha Yatra procession',
    },
    {
      'name': 'Kumbh Mela',
      'date': 'Every 12 years',
      'desc': 'The largest spiritual gathering on Earth. Millions of devotees bathe in the holy Godavari.',
      'icon': 'assets/images/Kumbhamela.jpeg',
      'highlight': 'Shahi Snan at Ramkund',
    },
    {
      'name': 'Navratri & Dussehra',
      'date': 'October',
      'desc': 'Nine nights of Garba and Dandiya celebrations, culminating in the victory of good over evil.',
      'icon': 'assets/images/Navaratri.jpeg',
      'highlight': 'Dandiya Raas at grounds',
    },
  ];

  // ─── AI Plan Fallback ───
  static const List<Map<String, dynamic>> fallbackPlans = [
    {
      'name': 'The Pilgrim\'s Path',
      'tagline': 'Sacred Nashik in half a day',
      'stops': ['Trimbakeshwar Temple', 'Panchavati Ghats', 'Kalaram Temple'],
      'estimatedCost': '₹200–400',
      'highlights': 'Experience the spiritual heart of Nashik',
      'duration': '4 hours',
    },
    {
      'name': 'Wine & Dine',
      'tagline': 'Nashik\'s finest flavors',
      'stops': ['Sula Vineyards', 'Soma Wine Village', 'Nashik food street'],
      'estimatedCost': '₹1,500–2,500',
      'highlights': 'India\'s wine capital at its best',
      'duration': '6 hours',
    },
    {
      'name': 'Hidden Nashik',
      'tagline': 'Where locals actually go',
      'stops': ['Pandavleni Caves', 'Dugarwadi Waterfall', 'Old Nashik bazaar'],
      'estimatedCost': '₹300–600',
      'highlights': 'Off the tourist trail',
      'duration': '5 hours',
    },
  ];

  // ─── Traveler Posts ───
  static const List<Map<String, String>> travelerPosts = [
    {
      'user': 'Priya M.',
      'avatar': 'assets/images/user_priya.jpg',
      'image': 'assets/images/post_trimbak.jpg',
      'caption': 'The sunrise at Trimbakeshwar was absolutely magical! Must visit during monsoons. 🌧️🛕',
      'likes': '234',
      'time': '2 days ago',
      'type': 'photo',
    },
    {
      'user': 'Rahul K.',
      'avatar': 'assets/images/user_rahul.jpg',
      'image': 'assets/images/post_misal.jpg',
      'caption': 'Gram Yatra helped us find Sadhana Misal — the spiciest and best misal in Nashik! 🌶️🔥',
      'likes': '189',
      'time': '5 days ago',
      'type': 'photo',
    },
    {
      'user': 'Anita S.',
      'avatar': 'assets/images/user_anita.jpg',
      'image': 'assets/images/post_trek.jpg',
      'caption': 'Our family trek to Anjaneri Hills was unforgettable. The AI plan saved us so much time!',
      'likes': '312',
      'time': '1 week ago',
      'type': 'video',
    },
    {
      'user': 'Vikram T.',
      'avatar': 'assets/images/user_vikram.jpg',
      'image': 'assets/images/post_sula.jpg',
      'caption': 'Sula Vineyards sunset tour is a must. Pro tip: book the Beyond experience!',
      'likes': '156',
      'time': '2 weeks ago',
      'type': 'photo',
    },
  ];
}
