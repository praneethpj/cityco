import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cityco/blocs/booking/booking_bloc.dart';
import 'package:cityco/data/repositories/booking_repository.dart';
import 'package:cityco/models/booking_model.dart';
import 'package:cityco/models/room_model.dart';

// Mock implementation of BookingRepository
class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  group('BookingBloc', () {
    late BookingRepository bookingRepository;
    late BookingBloc bookingBloc;

    setUp(() {
      bookingRepository = MockBookingRepository();
      bookingBloc = BookingBloc(bookingRepository: bookingRepository);
    });

    test('initial state is BookingInitiate', () {
      expect(bookingBloc.state, BookingInitiate(countOfBookedRooms: 0));
    });

    test('emits BookingInitiate on BookingIniateEvent', () {
      final numberOfBookedRoomCount = 5;

      when(bookingRepository.getAllBookingCount())
          .thenAnswer((_) => Future.value(numberOfBookedRoomCount));

      bookingBloc.add(BookingIniateEvent());

      expectLater(
        bookingBloc,
        emits(BookingInitiate(countOfBookedRooms: numberOfBookedRoomCount)),
      );
    });

    test('emits BookingGetDatePricePerRange on SelectBookingRangeDate', () {
      final dateTimeRange = DateTimeRange(
        start: DateTime(2023, 7, 13),
        end: DateTime(2023, 7, 15),
      );
      final pricePerDay = 100;

      when(bookingRepository.getRoomAvailabilityByDateRange(dateTimeRange))
          .thenAnswer((_) => Future.value(true));
      when(bookingRepository.getCostPerRange(dateTimeRange, pricePerDay))
          .thenAnswer((_) => Future.value(300));

      bookingBloc.add(SelectBookingRangeDate(
        dateTimeRange: dateTimeRange,
        pricePerDay: pricePerDay,
      ));

      expectLater(
        bookingBloc,
        emits(BookingGetDatePricePerRange(
          pricePerRange: 300,
          startDate: dateTimeRange.start,
          endDate: dateTimeRange.end,
        )),
      );
    });

    tearDown(() {
      bookingBloc.close();
    });
  });
}
