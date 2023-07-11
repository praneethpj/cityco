import 'package:cityco/models/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomRepository {
  final roomRef = FirebaseFirestore.instance;
  final collectionName = "room";

  Future<List<RoomModel>> getAllRooms() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection(collectionName);

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
        FirebaseFirestore.instance.collection(collectionName).doc(id);

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
