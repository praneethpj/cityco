import 'package:cached_network_image/cached_network_image.dart';
import 'package:cityco/blocs/authentication/auth_bloc.dart';
import 'package:cityco/blocs/room/room_bloc.dart';
import 'package:cityco/configurations/app_color.dart';
import 'package:cityco/configurations/app_constant.dart';
import 'package:cityco/screens/product_description.dart';
import 'package:cityco/widgets/customized_circular_indicator.dart';
import 'package:cityco/widgets/home/room_status_widget_container.dart';
import 'package:cityco/widgets/home/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/home/image_widget_container.dart';
import '../widgets/home/text_widget_container.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Image.asset(
            "assets/images/logo.png",
            width: _deviceSize.width / 10,
            height: _deviceSize.height / 10,
          ),
          backgroundColor: themeColor,
          centerTitle: true,
          title: Text(
            appName,
            style: GoogleFonts.aBeeZee(
                color: mainTextColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
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
        body: BlocBuilder<RoomBloc, RoomState>(
          builder: (context, state) {
            if (state is RoomLoading) {
              return const CustomizedCircularIndicator();
            } else if (state is RoomLoaded) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: _deviceSize.height / 40,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: TextFieldWidget(
                          readOnly: false,
                          hintText: "search",
                          icon: Icon(
                            Icons.search,
                          )),
                    ),
                    SizedBox(
                      height: _deviceSize.height / 40,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "Hello, User  👋",
                          style: GoogleFonts.akshar(
                              color: mainTextColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          //"Booking Count ${state.roomModel.length}"
                          "We have recorded ${state.roomModel.length} Bookings",
                          style: GoogleFonts.akshar(
                            color: mainTextColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _deviceSize.height / 40,
                    ),
                    SizedBox(
                      height: _deviceSize.height / 2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.roomModel.length,
                        itemBuilder: (context, index) {
                          final room = state.roomModel[index];
                          return GestureDetector(
                            onTap: () {
                              context.read<RoomBloc>().add(RoomGetByDocumentId(
                                  documentId: room.documentId));
                              Navigator.pushNamed(
                                  context, ProductDescription.routeName);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90)),
                              child: Stack(
                                children: [
                                  Positioned(
                                    child:
                                        ImageWidgetContainer(image: room.image),
                                  ),
                                  Positioned(
                                      child: RoomStatusWidgetContainer(
                                          roomStatus: room.availability)),
                                  Positioned(
                                    bottom: 0,
                                    child: TextWidgetContainer(
                                      roomName: room.name,
                                      price: room.pricePerDay,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is RoomEmpty) {
              return Text("No rooms");
            } else if (state is RoomError) {
              return Text("Rooms Errors");
            } else {
              return const CustomizedCircularIndicator();
            }
          },
        ),
      ),
    );
  }
}
