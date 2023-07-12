import 'package:cached_network_image/cached_network_image.dart';
import 'package:cityco/blocs/booking/booking_bloc.dart';
import 'package:cityco/blocs/room/room_bloc.dart';
import 'package:cityco/configurations/app_color.dart';
import 'package:cityco/configurations/app_constant.dart';
import 'package:cityco/widgets/customized_circular_indicator.dart';
import 'package:cityco/widgets/product_description/price_range_calander.dart';
import 'package:cityco/widgets/product_description/room_booking_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../widgets/home/text_field_widget.dart';

class ProductDescription extends StatelessWidget {
  static const String routeName = "/product_description";
  const ProductDescription({super.key});

  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              context.read<RoomBloc>().add(RoomFetchAll());
              context.read<BookingBloc>().add(BookingIniateEvent());
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: mainTextColor,
            )),
        backgroundColor: themeColor,
        centerTitle: true,
        title: Text(
          appName,
          style: GoogleFonts.aBeeZee(
              color: mainTextColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: SingleChildScrollView(
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
                      child: TextFieldWidget(
                          readOnly: false,
                          hintText: "Enter Your Name",
                          icon: Icon(
                            Icons.account_box_outlined,
                          )),
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RoomBookingButton(
                                pricePerDate: state.roomModel.pricePerDay),
                          )),
                    ),
                  ],
                ),
              );
            } else {
              return CustomizedCircularIndicator();
            }
          },
        ),
      ),
    ));
  }
}
