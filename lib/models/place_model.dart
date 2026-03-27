/// Model class for Place/POI data
class Place {
  final String xid;
  final String name;
  final String category;
  final int rate;
  final double lat;
  final double lng;
  final String description;
  final String photo;
  final String address;
  final String kinds;

  const Place({
    required this.xid,
    required this.name,
    required this.category,
    required this.rate,
    required this.lat,
    required this.lng,
    required this.description,
    required this.photo,
    required this.address,
    required this.kinds,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      xid: json['xid'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      rate: json['rate'] as int,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      description: json['description'] as String,
      photo: json['photo'] as String,
      address: json['address'] as String,
      kinds: json['kinds'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'xid': xid,
      'name': name,
      'category': category,
      'rate': rate,
      'lat': lat,
      'lng': lng,
      'description': description,
      'photo': photo,
      'address': address,
      'kinds': kinds,
    };
  }

  /// Get marker color based on category
  double get markerHue {
    switch (category.toLowerCase()) {
      case 'pilgrimage':
        return 340.0; // Burgundy/Rose
      case 'nature':
        return 120.0; // Green
      case 'food':
        return 30.0; // Orange/Saffron
      case 'adventure':
        return 210.0; // Blue
      case 'history':
        return 60.0; // Yellow
      default:
        return 0.0; // Red (default)
    }
  }
}
