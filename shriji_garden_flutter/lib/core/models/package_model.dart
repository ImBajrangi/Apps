class Package {
  final int id;
  final String name;
  final int price;
  final List<String> features;
  final String imageUrl;

  const Package({
    required this.id,
    required this.name,
    required this.price,
    required this.features,
    required this.imageUrl,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      features: List<String>.from(json['features'] as List),
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'features': features,
      'imageUrl': imageUrl,
    };
  }

  // Sample packages data
  static List<Package> get samplePackages => [
    const Package(
      id: 1,
      name: 'Silver Package',
      price: 10000,
      features: [
        'Venue for 1 day',
        'Basic decoration',
        'Catering for 100 guests',
        'Sound system',
      ],
      imageUrl: 'https://images.unsplash.com/photo-1519741497674-611481863552?q=80&w=2070&auto=format&fit=crop',
    ),
    const Package(
      id: 2,
      name: 'Gold Package',
      price: 20000,
      features: [
        'Venue for 2 days',
        'Premium decoration',
        'Catering for 200 guests',
        'DJ and sound system',
        'Photography',
      ],
      imageUrl: 'https://images.unsplash.com/photo-1511285560921-4c9262781216?q=80&w=2070&auto=format&fit=crop',
    ),
    const Package(
      id: 3,
      name: 'Platinum Package',
      price: 30000,
      features: [
        'Venue for 3 days',
        'Luxury decoration',
        'Catering for 300 guests',
        'Live band, DJ and sound system',
        'Videography and Photography',
        'Fireworks',
      ],
      imageUrl: 'https://images.unsplash.com/photo-1522120177514-2b16843a942f?q=80&w=2070&auto=format&fit=crop',
    ),
  ];
}
