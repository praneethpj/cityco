import 'package:cloud_firestore/cloud_firestore.dart';

class BookingRepository {
  final bookingRef = FirebaseFirestore.instance;

  Future<CollectionReference<Map<String, dynamic>>> getAllBooking() async {
    return bookingRef.collection('bookings');
  }
}
