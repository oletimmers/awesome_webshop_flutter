import 'package:awesome_webshop/components/products_screen/product_card.dart';
import 'package:awesome_webshop/models/product.dart';
import 'package:awesome_webshop/service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  static const String id = 'products_screen';

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Widget> productsList = [];

  @override
  void initState() {
    super.initState();
    setProducts();
  }

  void setProducts() async {
    if(productsList.length > 0) {return;}
    List<Product> products = await FirestoreService.instance.getAllProducts();
    List<Widget> productWidgets = [];
    for (var prod in products) {
      productWidgets.add(ProductCard(product: prod));
    }
    setState(() {
      productsList = productWidgets;
    });

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height / 3.5;
    final double itemWidth = size.width / 2 - 16;

    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      childAspectRatio: (itemWidth / itemHeight),
      primary: false,
      crossAxisSpacing: 2,
      mainAxisSpacing: 0,
      crossAxisCount: 2,
      children: productsList,
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
