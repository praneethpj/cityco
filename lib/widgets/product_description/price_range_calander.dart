import 'package:cityco/helper/formatter.dart';
import 'package:cityco/widgets/customized_circular_indicator.dart';
import 'package:cityco/widgets/home/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/booking/booking_bloc.dart';

class PriceRangeCalender extends StatelessWidget {
  final pricePerDate;
  const PriceRangeCalender({super.key, required this.pricePerDate});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        if (state is BookingInitiate) {
          return TextFieldWidget(
            onTap: () => _showDateRangePicker(context, pricePerDate),
            readOnly: true,
            hintText: "Select Your Date",
            icon: Icon(Icons.calendar_today_outlined),
          );
        } else if (state is BookingGetDatePricePerRange) {
          return TextFieldWidget(
            onTap: () => _showDateRangePicker(context, pricePerDate),
            readOnly: true,
            hintText:
                " ${Formatter.dateFormatter(state.startDate)} - ${Formatter.dateFormatter(state.endDate)}",
            icon: Icon(Icons.calendar_today_outlined),
          );
          ;
        } else {
          return CustomizedCircularIndicator();
        }
      },
    );
  }

  Future<void> _showDateRangePicker(
      BuildContext context, num pricePerDay) async {
    Future<DateTimeRange?> dateTimeRange = showDateRangePicker(
        context: context, firstDate: DateTime(1900), lastDate: DateTime(2100));

    var selectedDateTimeRange = await dateTimeRange;
    if (dateTimeRange == null) return;
    context.read<BookingBloc>().add(SelectBookingRangeDate(
        dateTimeRange: selectedDateTimeRange!, pricePerDay: pricePerDay));
  }
}
