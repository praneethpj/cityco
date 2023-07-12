class BookingModel {
  final String bookingDocumentId;
  final String roomDocumentId;
  final String customerId;
  final String roomName;
  final DateTime startDate;
  final DateTime endDate;

  BookingModel(
      {required this.bookingDocumentId,
      required this.roomDocumentId,
      required this.customerId,
      required this.roomName,
      required this.startDate,
      required this.endDate});
}
