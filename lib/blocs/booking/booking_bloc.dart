import 'package:cityco/blocs/room/room_bloc.dart';
import 'package:cityco/data/repositories/booking_repository.dart';
import 'package:cityco/models/booking_model.dart';
import 'package:cityco/models/room_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;
  BookingBloc({required this.bookingRepository}) : super(BookingInitiate()) {
    on<BookingIniateEvent>((event, state) {
      emit(BookingInitiate());
    });

    on<SelectBookingRangeDate>((event, state) {
      try {
        bookingRepository
            .getCostPerRange(event.dateTimeRange, event.pricePerDay)
            .then((pricePerRange) => emit(BookingGetDatePricePerRange(
                pricePerRange: pricePerRange,
                startDate: event.dateTimeRange.start,
                endDate: event.dateTimeRange.end)));
      } catch (e) {
        emit(BookingSelectError(message: e.toString()));
      }
    });
  }
}
