import 'package:awesome_webshop/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeButton extends StatelessWidget {
  final String text;
  final String routeID;

  WelcomeButton({required this.text, this.routeID = ProductsScreen.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 32.0, right: 32.0),
      child: Column(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: GoogleFonts.roboto(
                fontSize: 20,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, routeID);
            },
            child: Text(
              text,
              // style: TextStyle(color: Colors.teal.shade900,),
              style: TextStyle(color: Colors.black,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64.0),
            child: Divider(
              color: Colors.black54,
              height: 1,
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
