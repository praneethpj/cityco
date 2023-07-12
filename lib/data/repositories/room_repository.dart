import 'package:cityco/models/booking_model.dart';
import 'package:cityco/models/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoomRepository {
  final firebaseRef = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final roomCollectionName = "room";
  final bookingCollectionName = "booking";

  Future<List<RoomModel>> getAllRooms() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        firebaseRef.collection(roomCollectionName);

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
        firebaseRef.collection(roomCollectionName).doc(id);

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

  Future<void> makeRoomBook(RoomModel roomModel) async {
    final uid = firebaseAuth.currentUser!.uid;
    firebaseRef
        .collection(roomCollectionName)
        .doc(roomModel.documentId)
        .update({"availability": false});

    // BookingModel bookingModel=BookingModel(id: roomModel.documentId, customerId: uid, roomName: roomModel.name,  startDate: roomModel, endDate: endDate)

    // firebaseRef.collection(bookingCollectionName).doc().set({"": ""});
  }
}
