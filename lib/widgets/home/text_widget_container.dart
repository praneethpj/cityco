import 'package:cityco/configurations/app_color.dart';
import 'package:cityco/configurations/app_constant.dart';
import 'package:cityco/helper/formatter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidgetContainer extends StatelessWidget {
  final String roomName;
  final num price;
  TextWidgetContainer({super.key, required this.roomName, required this.price});

  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      child: Container(
          width: _deviceSize.width * 0.8,
          color: cardTransparentColor,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    roomName,
                    style: GoogleFonts.abel(
                        color: cardTextColor,
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
                    "${priceSymbol} ${Formatter.priceFormatter(price)}",
                    style: GoogleFonts.abel(
                      color: cardTextColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
