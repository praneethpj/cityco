import 'package:cityco/configurations/app_color.dart';
import 'package:flutter/material.dart';

class CustomizedCircularIndicator extends StatelessWidget {
  const CustomizedCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: progressColor,
    );
  }
}
