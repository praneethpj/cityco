part of 'booking_bloc.dart';

abstract class BookingState extends Equatable {
  @override
  List<BookingModel> get props => [];
}

class BookingInitiate extends BookingState {
  @override
  List<BookingModel> get props => [];
}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<BookingModel> bookingModel;
  BookingLoaded({required this.bookingModel});
}

class BookingSuccess extends BookingState {
  final String message;
  BookingSuccess({required this.message});
}

class BookingError extends BookingState {
  final String message;
  BookingError({required this.message});
}

// class BookingGetDateInitiate extends BookingState {
//   final double pricePerDate;
//   BookingGetDateInitiate({required this.pricePerDate});
// }

class BookingGetDatePricePerRange extends BookingState {
  final num pricePerRange;
  final DateTime startDate;
  final DateTime endDate;
  BookingGetDatePricePerRange(
      {required this.pricePerRange,
      required this.startDate,
      required this.endDate});
}

class BookingSelectError extends BookingState {
  final String message;
  BookingSelectError({required this.message});
}
