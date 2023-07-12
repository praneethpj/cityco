import 'package:cityco/blocs/booking/booking_bloc.dart';
import 'package:cityco/blocs/room/room_bloc.dart';
import 'package:cityco/blocs/textInput/text_input_bloc.dart';
import 'package:cityco/configurations/app_color.dart';
import 'package:cityco/configurations/app_constant.dart';
import 'package:cityco/helper/formatter.dart';
import 'package:cityco/models/booking_model.dart';
import 'package:cityco/models/room_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../customized_circular_indicator.dart';

class RoomBookingButton extends StatelessWidget {
  final RoomModel roomModel;
  const RoomBookingButton({super.key, required this.roomModel});

  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        if (state is BookingInitiate) {
          return SizedBox(
              width: _deviceSize.width,
              height: _deviceSize.height / 15,
              child: ElevatedButton(
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.shopping_bag_outlined),
                    Text(
                      "Book this Room at ${priceSymbol} ${Formatter.priceFormatter(roomModel.pricePerDay)}",
                      style: GoogleFonts.abel(fontSize: 20),
                    ),
                  ],
                ),
              ));
        } else if (state is BookingGetDatePricePerRange) {
          return context
                  .read<TextInputBloc>()
                  .bookingRepository
                  .getRoomModel()
                  .availability
              ? SizedBox(
                  width: _deviceSize.width,
                  height: _deviceSize.height / 15,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(buttonColor)),
                    onPressed: () {
                      String custometName = context
                          .read<TextInputBloc>()
                          .bookingRepository
                          .getCustomerName();

                      if (custometName.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Please enter your name'),
                        ));
                      } else {
                        context.read<BookingBloc>().add(CreateBooking());
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.shopping_bag_outlined),
                        Text(
                          "Book this Room at ${priceSymbol} ${Formatter.priceFormatter(state.pricePerRange)}",
                          style: GoogleFonts.abel(fontSize: 20),
                        ),
                      ],
                    ),
                  ))
              : SizedBox(
                  width: _deviceSize.width,
                  height: _deviceSize.height / 15,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.shopping_bag_outlined),
                        Text(
                          "This room is not available",
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
