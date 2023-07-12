import 'package:cityco/configurations/app_color.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final bool readOnly;
  final VoidCallback? onTap;

  const TextFieldWidget(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.readOnly,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      decoration: InputDecoration(
        filled: true,
        fillColor: themeColor,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: hintText,
      ),
    );
  }
}
