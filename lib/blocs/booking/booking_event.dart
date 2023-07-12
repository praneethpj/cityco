part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<BookingModel> get props => [];
}

class BookingIniateEvent extends BookingEvent {
  @override
  List<BookingModel> get props => [];
}

class CreateBooking extends BookingEvent {}

class SetPricePerDay extends BookingEvent {
  final num pricePerDay;
  SetPricePerDay({required this.pricePerDay});
}

class SelectBookingRangeDate extends BookingEvent {
  final DateTimeRange dateTimeRange;
  final num pricePerDay;

  SelectBookingRangeDate(
      {required this.dateTimeRange, required this.pricePerDay});
  @override
  List<BookingModel> get props => [];
}

class CustomerNameEvent extends BookingEvent {
  final String name;
  CustomerNameEvent({required this.name});
}
