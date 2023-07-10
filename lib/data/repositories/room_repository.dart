import 'package:cityco/models/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomRepository {
  final roomRef = FirebaseFirestore.instance;

  Future<List<RoomModel>> getAllBooking() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection('room');

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();

    List<RoomModel> roomList = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return RoomModel(
        roomId: doc.id,
        name: data['name'],
        description: data['description'],
        pricePerDay: data['pricePerDay'],
        availability: data['availability'],
      );
    }).toList();

    return roomList;
  }
}
