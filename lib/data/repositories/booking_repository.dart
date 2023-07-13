import 'package:cityco/models/booking_model.dart';
import 'package:cityco/models/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingRepository {
  final _collectionRef = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _roomCollectionName = "room";
  final _bookingCollectionName = "booking";

  late String _customerName;
  late RoomModel _roomModel;
  late DateTimeRange _dateTimeRange;
  late num _totalPrice;

  Future<CollectionReference<Map<String, dynamic>>> getAllBooking() async {
    return _collectionRef.collection(_bookingCollectionName);
  }

  Future<int> getAllBookingCount() async {
    Future<AggregateQuerySnapshot> bookingModelCount = _collectionRef
        .collection(_bookingCollectionName)
        .where("customerId", isEqualTo: getUid())
        .count()
        .get();
    AggregateQuerySnapshot numberOfRooms = await bookingModelCount;
    return numberOfRooms.count;
  }

  Future<num> getCostPerRange(
      DateTimeRange dateTimeRange, num perDayPrice) async {
    final costPerRange = dateTimeRange.duration.inDays * perDayPrice;
    _dateTimeRange = dateTimeRange;
    _totalPrice = costPerRange;

    return costPerRange;
  }

  Future<bool> makeBookingARoom(BookingModel bookingModel) async {
    try {
      await _collectionRef.collection(_bookingCollectionName).add({
        "roomDocumentId": bookingModel.roomDocumentId,
        "customerName": bookingModel.customerName,
        "customerId": bookingModel.customerId,
        "roomName": bookingModel.roomName,
        "startDate": bookingModel.startDate,
        "endDate": bookingModel.endDate,
        "totalPrice": bookingModel.totalPrice,
      });
      await _collectionRef
          .collection(_roomCollectionName)
          .doc(bookingModel.roomDocumentId)
          .update({"availability": false});
      return true;
    } catch (e) {
      return false;
    }
  }

  void addCustomerName(String customerName) {
    _customerName = customerName;
  }

  String getCustomerName() {
    return _customerName;
  }

  void addRoomModel(RoomModel roomModel) {
    _roomModel = roomModel;
  }

  Future<bool> getRoomAvailabilityByDateRange(
      DateTimeRange dateTimeRange) async {
    final snapshot = await _collectionRef
        .collection(_bookingCollectionName)
        .where("roomDocumentId", isEqualTo: getRoomModel().documentId)
        .get();

    for (final doc in snapshot.docs) {
      final bookingStartDate = doc.data()["startDate"].toDate();
      final bookingEndDate = doc.data()["endDate"].toDate();

      if (dateTimeRange.start.isBefore(bookingEndDate) &&
          dateTimeRange.end.isAfter(bookingStartDate)) {
        getRoomModel().availability = false;
        return false;
      }
    }

    return true;
  }

  RoomModel getRoomModel() {
    return _roomModel;
  }

  DateTimeRange getSelectedDateRange() {
    return _dateTimeRange;
  }

  num getTotalCostPerRange() {
    return _totalPrice;
  }

  String getUid() {
    final uid = _firebaseAuth.currentUser!.uid;
    return uid;
  }

  void clear() {
    _customerName = "";
    _roomModel.availability = true;
  }
}
