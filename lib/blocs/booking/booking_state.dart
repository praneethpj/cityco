part of 'booking_bloc.dart';

abstract class BookingState extends Equatable {
  @override
  List<Object> get props => [];
}

class BookingInitiate extends BookingState {
  final int countOfBookedRooms;
  BookingInitiate({required this.countOfBookedRooms});
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

class BookingFailed extends BookingState {
  final String message;
  BookingFailed({required this.message});
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
  @override
  List<Object> get props => [pricePerRange, startDate, endDate];
}

class BookingSelectError extends BookingState {
  final String message;
  BookingSelectError({required this.message});
}

class CustomerNameState extends BookingState {
  final String name;
  CustomerNameState({required this.name});
}
