import 'package:cached_network_image/cached_network_image.dart';
import 'package:cityco/blocs/booking/booking_bloc.dart';
import 'package:cityco/blocs/room/room_bloc.dart';
import 'package:cityco/blocs/textInput/text_input_bloc.dart';
import 'package:cityco/configurations/app_color.dart';
import 'package:cityco/widgets/customized_circular_indicator.dart';
import 'package:cityco/widgets/home/room_status_widget_container.dart';
import 'package:cityco/widgets/product_description/price_range_calander.dart';
import 'package:cityco/widgets/product_description/room_booking_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/base_app_bar.dart';
import '../widgets/text_field_widget.dart';

class ProductDescription extends StatelessWidget {
  static const String routeName = "/product_description";
  const ProductDescription({super.key});

  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        homePage: false,
        leading_icon_Button: IconButton(
            onPressed: () {
              context.read<RoomBloc>().add(RoomFetchAll());
              context.read<BookingBloc>().add(BookingIniateEvent());
              context.read<BookingBloc>().bookingRepository.clear();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: mainTextColor,
            )),
      ),
      body: SingleChildScrollView(
          child: BlocListener(
        bloc: BlocProvider.of<BookingBloc>(context),
        listener: (context, state) {
          if (state is BookingSuccess) {
            context.read<RoomBloc>().add(RoomFetchAll());
            context.read<BookingBloc>().add(BookingIniateEvent());
            context.read<BookingBloc>().bookingRepository.clear();
            Navigator.pop(context);
          } else if (state is RoomIsNotAvailble) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text('Date range conflicts, Please select another range')));
          }
        },
        child: SafeArea(
          child: BlocBuilder<RoomBloc, RoomState>(
            builder: (context, state) {
              if (state is RoomGetByDocumentIdRequest) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: SizedBox(
                            child: Stack(
                              children: [
                                Positioned(
                                    child: CachedNetworkImage(
                                  filterQuality: FilterQuality.high,
                                  width: _deviceSize.width,
                                  height: _deviceSize.height / 1.7,
                                  fit: BoxFit.cover,
                                  imageUrl: state.roomModel.image,
                                  placeholder: (context, url) =>
                                      const CustomizedCircularIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Text("Url is corrupted"),
                                )),
                                Positioned(
                                    child: RoomStatusWidgetContainer(
                                        roomStatus:
                                            state.roomModel.availability)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            state.roomModel.name,
                            style: GoogleFonts.abel(
                                color: mainTextColor,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            state.roomModel.description,
                            style: GoogleFonts.abel(
                              color: mainTextColor,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: PriceRangeCalender(
                                pricePerDate: state.roomModel.pricePerDay)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: Expanded(
                          child: TextFieldWidget(
                            icon: Icon(Icons.account_box_outlined),
                            readOnly: false,
                            hintText: "Enter Your Name",
                            onChange: (value) => {
                              context
                                  .read<TextInputBloc>()
                                  .add(TextInputChange(data: value!))
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: RoomBookingButton(
                                roomModel: state.roomModel,
                              ),
                            )),
                      ),
                    ],
                  ),
                );
              } else if (state is RoomError) {
                return Text(state.message);
              } else {
                return CustomizedCircularIndicator();
              }
            },
          ),
        ),
      )),
    );
  }
}
