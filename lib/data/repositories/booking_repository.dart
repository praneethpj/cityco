import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingRepository {
  final bookingRef = FirebaseFirestore.instance;

  Future<CollectionReference<Map<String, dynamic>>> getAllBooking() async {
    return bookingRef.collection('bookings');
  }

  Future<num> getCostPerRange(
      DateTimeRange dateTimeRange, num perDayPrice) async {
    final costPerRange = dateTimeRange.duration.inDays * perDayPrice;
    return costPerRange;
  }
}
