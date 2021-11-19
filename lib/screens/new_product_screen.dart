import 'dart:convert';
import 'package:awesome_webshop/models/product.dart';
import 'package:awesome_webshop/screens/products_screen.dart';
import 'package:awesome_webshop/service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';

class NewProductScreen extends StatefulWidget {
  static const String id = 'new_product_screen';


  @override
  _NewProductScreenState createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {

  bool showSpinner = false;
  String title = "";
  String shortDescription = "";
  String description = "";
  double price = 99.99;
  String imgBase64 = "";
  String color = "";

  var imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nieuw product', style: GoogleFonts.roboto(),),
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 4.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.name,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        title = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Titel',
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.name,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        shortDescription = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Korte beschrijving',
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        description = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Lange beschrijving',
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        price = double.parse(value);
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: '19.99',
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.name,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        color = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Kleur',
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    IconButton(onPressed: () async {
                      XFile image = await imagePicker.pickImage(
                          source: ImageSource.gallery, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
                      List<int> imageBytes = await image.readAsBytes();
                      imgBase64 = base64Encode(imageBytes);
                    }, icon: Icon(Icons.image)),


                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen.shade300),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Verstuur',
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 24
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          await FirestoreService.instance.addProduct(Product(
                            title,
                            shortDescription,
                            description,
                            price,
                            imgBase64,
                            color
                          ));
                          setState(() {
                            showSpinner = false;
                            Navigator.pushNamed(context, ProductsScreen.id);
                          });

                        } catch(e) {
                          print(e);
                        }
                      },
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
