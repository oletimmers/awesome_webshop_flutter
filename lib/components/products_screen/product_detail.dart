import 'package:awesome_webshop/models/product.dart';
import 'package:awesome_webshop/models/winkelmandje.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  ProductDetail({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 8,
            right: -50.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Image(image: product.getImage()),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      product.title,
                      style: GoogleFonts.roboto(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.shortDescription,
                      style: GoogleFonts.roboto(
                        fontSize: 14.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade700,
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Voor 23:59 besteld => Morgen in huis!!!',
                        style: GoogleFonts.roboto(
                          fontSize: 13.0,
                          color: Colors.orange,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Text(
                      product.description.replaceAll(' \\n ', '\n\n'),
                      style: GoogleFonts.roboto(
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 120),
              child: Container(
                height: 64.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prijs: ',
                      style: GoogleFonts.roboto(
                          color: Colors.grey.shade300,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2,
                          fontSize: 18),
                    ),
                    Text(
                      product.getPriceFormatted(),
                      style: GoogleFonts.roboto(
                          color: Colors.lightGreen.shade300,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2,
                          fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                  onPressed: () {
                    // TODO: Winkelmandje-provider
                    Provider.of<Winkelmandje>(context, listen: false).addProduct(product);
                  },
                child: Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
