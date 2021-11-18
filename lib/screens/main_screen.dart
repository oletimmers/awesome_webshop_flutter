import 'package:awesome_webshop/components/awesome_webshop_logo.dart';
import 'package:awesome_webshop/components/navigation_bar.dart';
import 'package:awesome_webshop/constants.dart';
import 'package:awesome_webshop/screens/products_screen.dart';
import 'package:awesome_webshop/screens/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'account_screen.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  int initialIndex;


  MainScreen({this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String title = "";
  int currentIndexOfNav = 0;
  Widget body = ProductsScreen();



  @override
  void initState() {
    currentIndexOfNav = widget.initialIndex;
    super.initState();
    if (currentIndexOfNav == 0) {
        title = 'Alle producten';
        body = ProductsScreen();
    } else if(currentIndexOfNav == 1){
      title = 'Winkelmandje';
      body = ShoppingCartScreen();
    } else {
        body = AccountScreen();
    }
  }

  void onTapNavBar(int index) {
    if (index == currentIndexOfNav) {
      return;
    }
    if (index == 0) {
      setState(() {
        currentIndexOfNav = index;
        title = 'Alle producten';
        body = ProductsScreen();
      });
    } else if(index == 1){
      setState(() {
        currentIndexOfNav = index;
        title = 'Winkelmandje';
        body = ShoppingCartScreen();
      });
    } else {
      setState(() {
        currentIndexOfNav = index;
        title = '';
        body = AccountScreen();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black12,
        elevation: 3,
        leadingWidth: 140.0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: kLogoHeroTag,
              flightShuttleBuilder: _flightShuttleBuilder,
              child: AwesomeWebshopLogo(fontSize: 20.0, color: Colors.black),
            ),
          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Text(title, style: GoogleFonts.comfortaa(
            color: Colors.teal.shade900,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.4,
            fontStyle: FontStyle.italic,
          ))],
        ),
      ),
      body: body,
      bottomNavigationBar: NavigationBar(currentIndex: currentIndexOfNav, changeScreenFunction: onTapNavBar,),
    );
  }
}



Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
    ) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}
