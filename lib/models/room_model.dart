class RoomModel {
  final String roomId;
  final String name;
  final String description;
  final double pricePerDay;
  final bool availability;

  RoomModel(
      {required this.roomId,
      required this.name,
      required this.description,
      required this.pricePerDay,
      required this.availability});
}
