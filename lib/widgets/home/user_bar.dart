import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configurations/app_color.dart';

class UserBar extends StatefulWidget {
  const UserBar({super.key});

  @override
  State<UserBar> createState() => _UserBarState();
}

class _UserBarState extends State<UserBar> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Hello, User  👋",
      style: GoogleFonts.akshar(
          color: mainTextColor, fontSize: 30, fontWeight: FontWeight.w400),
    );
  }
}
