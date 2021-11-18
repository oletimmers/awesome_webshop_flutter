import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class AwesomeWebshopLogo extends StatelessWidget {
  final double fontSize;
  final Color color;


  AwesomeWebshopLogo({required this.fontSize, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(
      kAppTitle,
      style: GoogleFonts.comfortaa(
        fontSize: fontSize,
        color: color,
      ),
      textAlign: TextAlign.center,
    );
  }
}