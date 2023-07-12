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

  BookingBloc({required this.bookingRepository})
      : super(BookingInitiate(countOfBookedRooms: 0)) {
    on<BookingIniateEvent>((event, state) async {
      int numberOfBookedRoomCount =
          await bookingRepository.getAllBookingCount();
      emit(BookingInitiate(countOfBookedRooms: numberOfBookedRoomCount));
    });

    on<SelectBookingRangeDate>((event, state) async {
      try {
        bookingRepository
            .getCostPerRange(event.dateTimeRange, event.pricePerDay)
            .then((pricePerRange) => {
                  emit(BookingGetDatePricePerRange(
                      pricePerRange: pricePerRange,
                      startDate: event.dateTimeRange.start,
                      endDate: event.dateTimeRange.end))
                });
      } catch (e) {
        emit(BookingSelectError(message: e.toString()));
      }
    });

    on<CreateBooking>((event, state) async {
      try {
        RoomModel roomModel = bookingRepository.getRoomModel();
        BookingModel bookingModel = BookingModel(
            bookingDocumentId: "",
            roomDocumentId: roomModel.documentId,
            customerName: bookingRepository.getCustomerName(),
            customerId: bookingRepository.getUid(),
            roomName: roomModel.name,
            startDate: bookingRepository.getSelectedDateRange().start,
            endDate: bookingRepository.getSelectedDateRange().end,
            totalPrice: bookingRepository.getTotalCostPerRange());

        Future<bool> status = bookingRepository.makeBookingARoom(bookingModel);

        if (await status) {
          emit(BookingSuccess(message: "Your Booking has been Successed"));
        } else {
          emit(BookingFailed(
              message:
                  "Your Booking has been Failed. Some thing has happened wrong"));
        }
      } catch (e) {
        emit(BookingSelectError(message: e.toString()));
      }
    });

    on<CustomerNameEvent>((event, state) {
      try {
        print(event.name);
        emit(CustomerNameState(name: event.name));
      } catch (e) {
        emit(BookingSelectError(message: e.toString()));
      }
    });
  }
}
