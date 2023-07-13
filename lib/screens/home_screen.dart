import 'package:cityco/blocs/room/room_bloc.dart';
import 'package:cityco/widgets/base_app_bar.dart';
import 'package:cityco/widgets/customized_circular_indicator.dart';
import 'package:cityco/widgets/home/booking_count_widget.dart';
import 'package:cityco/widgets/home/horizontal_item_display.dart';
import 'package:cityco/widgets/text_field_widget.dart';
import 'package:cityco/widgets/home/user_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: BaseAppBar(appBar: AppBar(), homePage: true),
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
                        child: UserBar(),
                      ),
                    ),
                    const BookingCountWidget(),
                    SizedBox(
                      height: _deviceSize.height / 40,
                    ),
                    const HorizontalItemDisplay(),
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
