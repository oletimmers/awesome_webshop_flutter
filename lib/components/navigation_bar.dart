import 'package:awesome_webshop/models/winkelmandje.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) changeScreenFunction;

  NavigationBar({this.currentIndex = 0, required this.changeScreenFunction});

  Widget getWwIcon(BuildContext context, List<WinkelmandProduct> products) {
    bool hasProducts = products.isNotEmpty;
    if (hasProducts) {
      return Badge(
        child: Icon(Icons.shopping_basket),
        badgeColor: Colors.red,
        badgeContent: Text(products.length.toString(),
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
      );
    } else {
      return Icon(Icons.shopping_basket);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.storefront),
          label: 'Producten',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: getWwIcon(context, Provider.of<Winkelmandje>(context).productenInMandje),
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