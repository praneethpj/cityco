import 'package:cityco/configurations/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoomStatusWidgetContainer extends StatelessWidget {
  final bool roomStatus;
  RoomStatusWidgetContainer({super.key, required this.roomStatus});

  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;
    return Container(
      width: _deviceSize.width * 0.7,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: roomStatus
                ? Container(
                    width: _deviceSize.width * 0.2,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: availabilityYesColor),
                    child: Center(
                      child: Text(
                        "Available",
                        style: GoogleFonts.abel(
                          color: cardTextColor,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      width: _deviceSize.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: availabilityNoColor,
                      ),
                      child: Center(
                        child: Text(
                          "Not Available",
                          style: GoogleFonts.abel(
                            color: cardTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
