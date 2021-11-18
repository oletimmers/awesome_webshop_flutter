import 'package:awesome_webshop/screens/account_screen.dart';
import 'package:awesome_webshop/screens/products_screen.dart';
import 'package:awesome_webshop/screens/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) changeScreenFunction;

  NavigationBar({this.currentIndex = 0, required this.changeScreenFunction});



  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.storefront),
          label: 'Producten',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket),
          label: 'Winkelmandje',
          backgroundColor: Color(0xFFAED581),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
          backgroundColor: Colors.grey,
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.teal[800],
      unselectedItemColor: Colors.teal.shade900,
      selectedLabelStyle: GoogleFonts.roboto(color: Colors.teal.shade900),
      unselectedLabelStyle: GoogleFonts.roboto(),
      onTap: (index) => changeScreenFunction(index),
    );
  }
}