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
    Future<AggregateQuerySnapshot> bookingModelCount =
        _collectionRef.collection(_bookingCollectionName).count().get();
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
  }
}
