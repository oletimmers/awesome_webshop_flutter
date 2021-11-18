import 'package:awesome_webshop/components/navigation_bar.dart';
import 'package:awesome_webshop/components/shopping_car_screen/shopping_cart_product_card.dart';
import 'package:awesome_webshop/models/winkelmandje.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatelessWidget {
  static const String id = 'shopping_cart_screen';

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
                      onPressed: () {
                        //TODO bevestigen
                      },
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
