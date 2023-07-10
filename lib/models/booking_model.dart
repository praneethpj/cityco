class BookingModel {
  final String id;
  final String customerId;
  final String roomName;
  final String customerName;
  final DateTime startDate;
  final DateTime endDate;

  BookingModel(
      {required this.id,
      required this.customerId,
      required this.roomName,
      required this.customerName,
      required this.startDate,
      required this.endDate});
}
