class BookingRequest {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String? date;
  final String? guests;
  final String? eventType;
  final String? catering;
  final String? decorationTheme;
  final List<String>? entertainment;
  final String? requests;
  final String? packageName;
  final String status;
  final DateTime submittedAt;
  final String? docId;

  const BookingRequest({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.date,
    this.guests,
    this.eventType,
    this.catering,
    this.decorationTheme,
    this.entertainment,
    this.requests,
    this.packageName,
    this.status = 'pending',
    required this.submittedAt,
    this.docId,
  });

  factory BookingRequest.fromJson(Map<String, dynamic> json, {String? docId}) {
    try {
      return BookingRequest(
        id: json['id'] as int?,
        name: (json['name'] ?? 'Unknown') as String,
        email: (json['email'] ?? '') as String,
        phone: (json['phone'] ?? '') as String,
        date: json['date'] as String?,
        guests: json['guests'] as String?,
        eventType: json['eventType'] as String?,
        catering: json['catering'] as String?,
        decorationTheme: json['decorationTheme'] as String?,
        entertainment: json['entertainment'] != null 
            ? List<String>.from(json['entertainment'] as List) 
            : null,
        requests: json['requests'] as String?,
        packageName: json['package'] as String?,
        status: json['status'] as String? ?? 'pending',
        submittedAt: json['submittedAt'] != null 
            ? DateTime.parse(json['submittedAt'] as String)
            : DateTime.now(),
        docId: docId,
      );
    } catch (e) {
      return BookingRequest(
        name: 'Error Parsing Data',
        email: '',
        phone: '',
        status: 'error',
        submittedAt: DateTime.now(),
        requests: 'Could not parse this booking: $e',
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'date': date,
      'guests': guests,
      'eventType': eventType,
      'catering': catering,
      'decorationTheme': decorationTheme,
      'entertainment': entertainment,
      'requests': requests,
      'package': packageName,
      'status': status,
      'submittedAt': submittedAt.toIso8601String(),
    };
  }

  // Sample requests for admin page
  static List<BookingRequest> get sampleRequests => [
    BookingRequest(
      id: 1,
      name: 'Radhe Kumar',
      email: 'radhe@example.com',
      phone: '9876756434',
      date: '2025-11-20',
      guests: '1000',
      requests: 'Looking forward to a grand wedding celebration',
      submittedAt: DateTime.parse('2025-11-10T15:01:39.560Z'),
    ),
    BookingRequest(
      id: 2,
      name: 'Shivam Sharma',
      email: 'shivam@gmail.com',
      phone: '8755827406',
      date: '2025-11-12',
      guests: '1000',
      eventType: 'Wedding',
      catering: 'Vegetarian',
      packageName: 'Gold Package',
      submittedAt: DateTime.parse('2025-11-11T10:09:59.935Z'),
    ),
    BookingRequest(
      id: 3,
      name: 'Priya Patel',
      email: 'priya@example.com',
      phone: '9988776655',
      date: '2025-12-15',
      guests: '500',
      eventType: 'Reception',
      catering: 'Non-Vegetarian',
      packageName: 'Platinum Package',
      submittedAt: DateTime.parse('2025-11-15T08:30:00.000Z'),
    ),
  ];
}
