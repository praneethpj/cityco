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
