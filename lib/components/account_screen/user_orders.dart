import 'package:awesome_webshop/models/order.dart';
import 'package:awesome_webshop/service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UserOrders extends StatefulWidget {

  @override
  _UserOrdersState createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  bool showSpinner = true;

  List<Widget> orderWidgets = [];

  @override
  void initState() {
    super.initState();
    setOrders();
  }

  void setOrders() async {
    List<Order> orders = await FirestoreService.instance.getAllOrders();
    List<Widget> newOrderWidgets = [];
    for (var ord in orders) {
      newOrderWidgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('yyyy-MM-dd').format(ord.timeStamp.toDate())),
            Text(ord.totalAmount),
          ],
        ),
      ));
    }
    setState(() {
      showSpinner = false;
      orderWidgets = newOrderWidgets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Uw bestellingen',
            style: GoogleFonts.roboto(
                fontSize: 18
            ),
          ),
          ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SizedBox(
              height: 150.0,
              child: ListView(
                children: orderWidgets,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
