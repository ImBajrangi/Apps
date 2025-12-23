import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking_request_model.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'bookings';

  // Create - Save a new booking
  Future<void> submitBooking(Map<String, dynamic> data) async {
    try {
      final bookingData = {
        ...data,
        'submittedAt': DateTime.now().toIso8601String(),
        'status': 'pending', // Initial status
      };
      await _firestore.collection(_collection).add(bookingData);
    } catch (e) {
      throw Exception('Failed to submit booking: $e');
    }
  }

  // Read - Get all bookings as a stream for the Admin
  Stream<List<BookingRequest>> getBookingsStream() {
    return _firestore
        .collection(_collection)
        .orderBy('submittedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return BookingRequest.fromJson(data, docId: doc.id);
      }).toList();
    });
  }

  // Update - Change booking status
  Future<void> updateBookingStatus(String docId, String status) async {
    await _firestore.collection(_collection).doc(docId).update({
      'status': status,
    });
  }
}
