class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'ShriJi Garden';
  static const String appTagline = 'Find Your Perfect Wedding Venue';
  static const String appDescription = 
      'ShriJi Garden offers a beautiful setting for your special day. '
      'Let us help you create unforgettable memories.';

  // Contact Info
  static const String address = '123 Garden Lane, Serenity City, 12345';
  static const String phone = '(123) 456-7890';
  static const String email = 'contact@shrijigarden.com';

  // Social Links
  static const String facebookUrl = 'https://facebook.com/shrijigarden';
  static const String instagramUrl = 'https://instagram.com/shrijigarden';
  static const String twitterUrl = 'https://twitter.com/shrijigarden';

  // Media URLs
  static const String heroVideoUrl = 
      'https://videos.pexels.com/video-files/853804/853804-hd_1920_1080_25fps.mp4';
  
  static const List<String> galleryImages = [
    'https://images.unsplash.com/photo-1522120177514-2b16843a942f?q=80&w=2070&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1519225421980-715cb4a75abe?q=80&w=2070&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1511285560921-4c9262781216?q=80&w=2070&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1515934751635-481eff1081b3?q=80&w=2070&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1519741497674-611481863552?q=80&w=2070&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1518899695932-93e0a993b82f?q=80&w=2070&auto=format&fit=crop',
  ];

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);
}
