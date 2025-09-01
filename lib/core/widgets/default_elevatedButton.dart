import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moveis_app/core/app_colors.dart';

class DefaultElevatedbutton extends StatelessWidget {
  Color? backgroundColor;
  Color? foregroundColor;
  String text;
  void Function()? onPressed;
  DefaultElevatedbutton({
    this.text = '',
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(8),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.roboto(color: foregroundColor, fontSize: 20),
        ),
      ),
    );
  }
}
