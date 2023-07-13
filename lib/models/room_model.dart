class RoomModel {
  final String documentId;
  final String name;
  final String description;
  final String image;
  final num pricePerDay;
  bool availability;

  RoomModel(
      {required this.documentId,
      required this.name,
      required this.description,
      required this.image,
      required this.pricePerDay,
      required this.availability});
}
