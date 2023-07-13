import 'package:cityco/models/booking_model.dart';
import 'package:cityco/models/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoomRepository {
  final _firebaseRef = FirebaseFirestore.instance;

  final _roomCollectionName = "room";
  final _bookingCollectionName = "booking";

  Future<List<RoomModel>> getAllRooms() async {
    Query<Map<String, dynamic>> collectionReference =
        _firebaseRef.collection(_roomCollectionName).limit(5);

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();

    List<RoomModel> roomList = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();

      return RoomModel(
        documentId: doc.id,
        name: data['name'],
        description: data['description'],
        image: data['image'],
        pricePerDay: data['pricePerDay'],
        availability: data['availability'],
      );
    }).toList();

    return roomList;
  }

  Future<RoomModel> getRoomByDocumentId(String id) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        _firebaseRef.collection(_roomCollectionName).doc(id);

    Future<RoomModel> roomList =
        documentReference.get().then((data) => RoomModel(
              documentId: id,
              name: data['name'],
              description: data['description'],
              image: data['image'],
              pricePerDay: data['pricePerDay'],
              availability: data['availability'],
            ));

    return roomList;
  }
}
