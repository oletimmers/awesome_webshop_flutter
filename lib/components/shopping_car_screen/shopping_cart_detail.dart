import 'package:awesome_webshop/models/winkelmand_product.dart';
import 'package:awesome_webshop/models/winkelmandje.dart';
import 'package:awesome_webshop/screens/account_screen.dart';
import 'package:awesome_webshop/service/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ShoppingCartDetail extends StatefulWidget {

  Winkelmandje data;


  ShoppingCartDetail({required this.data});

  @override
  State<ShoppingCartDetail> createState() => _ShoppingCartDetailState();
}

class _ShoppingCartDetailState extends State<ShoppingCartDetail> {
  bool showSpinner = false;

  List<Widget> getProducts() {
    List<WinkelmandProduct> products = widget.data.productenInMandje;
    List<Widget> productWidgets = [];
    for (var prod in products) {
      productWidgets.add(
        SizedBox(
          height: 40.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      prod.product.title,
                      style: GoogleFonts.roboto(),
                    ),
                    Text(
                      '${prod.product.getPriceFormatted()} x ${prod.count}',
                      style: GoogleFonts.roboto(),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    prod.getPriceFormatted(),
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      );
    }
    return productWidgets;
  }

  void onConfirm() async {
    setState(() {
      showSpinner = true;
    });
    await FirestoreService.instance.confirmShoppingCart(widget.data);
    setState(() {
      showSpinner = false;
    });
    Navigator.pushNamed(context, AccountScreen.id);
    Provider.of<Winkelmandje>(context, listen: false).emptyWinkelmandje();
  }


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 16.0,
            left: 36.0,
            child: Text('Je bestelling bij \nAwesome \nWebshop: ',
              style: GoogleFonts.comfortaa(
                fontSize: 36.0,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                        '${widget.data.productenInMandje.length.toString()} ${widget.data.productenInMandje.length == 1 ? 'item' : 'items'}',
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                      ),
                    ),
                    Divider(
                      thickness: 4,
                      height: 16.0,
                      color: Colors.grey.shade700,
                    ),
                    Container(
                      height: 280.0,
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListView(
                        children: getProducts(),
                      ),
                    ),
                    Divider(
                      thickness: 4,
                      height: 16.0,
                      color: Colors.grey.shade700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Totaal: ',
                          style: GoogleFonts.roboto(
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          widget.data.getTotaalPrice(),
                          style: GoogleFonts.roboto(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              onConfirm();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'Bevestig en bestel',
                                style: GoogleFonts.comfortaa(
                                  color: Colors.black,
                                  fontSize: 24.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
