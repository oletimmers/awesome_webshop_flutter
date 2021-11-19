import 'package:awesome_webshop/components/navigation_bar.dart';
import 'package:awesome_webshop/components/shopping_car_screen/shopping_cart_detail.dart';
import 'package:awesome_webshop/components/shopping_car_screen/shopping_cart_product_card.dart';
import 'package:awesome_webshop/models/winkelmandje.dart';
import 'package:awesome_webshop/screens/registration_screen.dart';
import 'package:awesome_webshop/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class ShoppingCartScreen extends StatelessWidget {
  static const String id = 'shopping_cart_screen';

  void onConfirmShoppingCart(BuildContext context) {
    if (AuthService.instance.isLoggedInWithEmail()) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: ShoppingCartDetail(data: Provider.of<Winkelmandje>(context)),
        ),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Niet ingelogd'),
              content: Text('Om te bestellen heb je een account nodig, maak deze aan of log in.'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistrationScreen(routeIDFromCall: ShoppingCartScreen.id)),
                      );
                    },
                    child: Text('Registreer')),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen(routeIDFromCall: ShoppingCartScreen.id)),
                    );
                  },
                  child: Text('Login'),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Consumer<Winkelmandje>(
              builder: (context, winkelmandje, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ShoppingCardProductCard(
                      wmProduct: winkelmandje.productenInMandje[index],
                      indexFromList: index,
                    );
                  },
                  itemCount: winkelmandje.productenInMandje.length,
                );
              },
            ),
          ),
          Container(
            color: Colors.lightGreen.shade100,
            height: 64.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal),
                      ),
                      child: Text(
                        'Ga verder en bestel',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: Provider.of<Winkelmandje>(context).productenInMandje.isNotEmpty ? () {
                        onConfirmShoppingCart(context);
                      }: null,
                    ),
                    Text(
                      'Totaal:',
                      style: GoogleFonts.roboto(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      Provider.of<Winkelmandje>(context).getTotaalPrice(),
                      style: GoogleFonts.roboto(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
