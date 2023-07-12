import 'package:cityco/blocs/booking/booking_bloc.dart';
import 'package:cityco/configurations/app_color.dart';
import 'package:cityco/configurations/app_constant.dart';
import 'package:cityco/helper/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../customized_circular_indicator.dart';

class RoomBookingButton extends StatelessWidget {
  final pricePerDate;
  const RoomBookingButton({super.key, required this.pricePerDate});

  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        if (state is BookingInitiate) {
          return SizedBox(
              width: _deviceSize.width,
              height: 60,
              child: ElevatedButton(
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.shopping_bag_outlined),
                    Text(
                      "Book this Room at ${priceSymbol} ${Formatter.priceFormatter(pricePerDate)}",
                      style: GoogleFonts.abel(fontSize: 20),
                    ),
                  ],
                ),
              ));
        } else if (state is BookingGetDatePricePerRange) {
          return SizedBox(
              width: _deviceSize.width,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(buttonColor)),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.shopping_bag_outlined),
                    Text(
                      "Book this Room at ${priceSymbol} ${state.pricePerRange}",
                      style: GoogleFonts.abel(fontSize: 20),
                    ),
                  ],
                ),
              ));
        } else {
          return CustomizedCircularIndicator();
        }
      },
    );
  }
}
