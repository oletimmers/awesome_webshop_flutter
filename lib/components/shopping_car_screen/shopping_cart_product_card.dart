import 'package:awesome_webshop/models/winkelmand_product.dart';
import 'package:awesome_webshop/models/winkelmandje.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShoppingCardProductCard extends StatelessWidget {
  final WinkelmandProduct wmProduct;
  final int indexFromList;

  ShoppingCardProductCard(
      {required this.wmProduct, required this.indexFromList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      height: 142.0,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(8),
                color: Colors.teal,
                child: Image(image: wmProduct.product.getImage())),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        wmProduct.product.title,
                        style: GoogleFonts.roboto(
                          color: Colors.teal.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                        ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${wmProduct.product.getPriceFormatted()} x ${wmProduct.count}',
                          style: GoogleFonts.roboto(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0
                          ),
                        ),
                        Text(
                          wmProduct.getPriceFormatted(),
                          style: GoogleFonts.roboto(
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            Provider.of<Winkelmandje>(context, listen: false).decreaseCountOfProduct(indexFromList);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Provider.of<Winkelmandje>(context, listen: false).increaseCountOfProduct(indexFromList);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 32.0,
                child: RotatedBox(
                    quarterTurns: 1,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      child: Text(
                        'Verwijder',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Provider.of<Winkelmandje>(context, listen: false).deleteProduct(wmProduct);
                      },
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
