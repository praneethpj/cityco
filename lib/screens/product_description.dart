import 'package:cached_network_image/cached_network_image.dart';
import 'package:cityco/blocs/room/room_bloc.dart';
import 'package:cityco/configurations/app_color.dart';
import 'package:cityco/configurations/app_constant.dart';
import 'package:cityco/widgets/customized_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          if (state is RoomGetByDocumentIdRequest) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: SizedBox(
                      child: CachedNetworkImage(
                        filterQuality: FilterQuality.high,
                        width: _deviceSize.width,
                        height: _deviceSize.height / 2,
                        fit: BoxFit.cover,
                        imageUrl: state.roomModel.image,
                        placeholder: (context, url) =>
                            const CustomizedCircularIndicator(),
                        errorWidget: (context, url, error) =>
                            Text("Url is corrupt"),
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
                  height: _deviceSize.height / 4,
                ),
                SizedBox(
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
                            "Book this Room at ${priceSymbol} ${state.roomModel.pricePerDay}",
                            style: GoogleFonts.abel(fontSize: 20),
                          ),
                        ],
                      )),
                )
              ],
            );
          } else {
            return CustomizedCircularIndicator();
          }
        },
      ),
    ));
  }
}
