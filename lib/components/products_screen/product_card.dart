import 'dart:typed_data';

import 'package:awesome_webshop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:typed_data';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  MemoryImage getImage() {
    return MemoryImage(base64Decode(product.imgBase64));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) => Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                ),
              );
            },
            child: Card(
              color: Colors.teal.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image(
                image: getImage(),
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                product.title,
                style: GoogleFonts.comfortaa(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                    color: Colors.teal.shade300),
                textAlign: TextAlign.start,
              ),
            ),
            Text(
              '€ ${product.price.toString().replaceFirst('.', ',')}',
              style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                  color: Colors.teal.shade700),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            height: 20,
            thickness: 1,
            color: Colors.teal,
          ),
        ),
      ],
    );
  }
}
