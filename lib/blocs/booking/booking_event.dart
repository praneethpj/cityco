part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<BookingModel> get props => [];
}

class CreateBooking extends BookingEvent {
  final BookingModel bookingModel;
  CreateBooking({required this.bookingModel});
}
