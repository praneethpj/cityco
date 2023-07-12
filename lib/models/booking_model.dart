class BookingModel {
  final String bookingDocumentId;
  final String roomDocumentId;
  final String customerName;
  final String customerId;
  final String roomName;
  final DateTime startDate;
  final DateTime endDate;
  final num totalPrice;

  BookingModel(
      {required this.bookingDocumentId,
      required this.roomDocumentId,
      required this.customerName,
      required this.customerId,
      required this.roomName,
      required this.startDate,
      required this.endDate,
      required this.totalPrice});

  Map<String, dynamic> toJson() => {
        "roomDocumentId": roomDocumentId,
        "customerName": customerName,
        "customerId": customerId,
        "roomName": roomName,
        "startDate": startDate,
        "endDate": endDate,
        "totalPrice": totalPrice,
      };
}
