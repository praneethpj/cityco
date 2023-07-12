import 'package:cityco/blocs/booking/booking_bloc.dart';
import 'package:cityco/blocs/room/room_bloc.dart';
import 'package:cityco/configurations/app_color.dart';
import 'package:cityco/widgets/customized_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingCountWidget extends StatelessWidget {
  const BookingCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        if (state is BookingInitiate) {
          return Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                //"Booking Count ${state.roomModel.length}"
                "We have recorded ${state.countOfBookedRooms} Bookings",
                style: GoogleFonts.akshar(
                  color: mainTextColor,
                  fontSize: 16,
                ),
              ),
            ),
          );
        } else {
          return CustomizedCircularIndicator();
        }
      },
    );
  }
}
