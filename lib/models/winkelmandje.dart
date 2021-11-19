import 'dart:collection';

import 'package:awesome_webshop/models/product.dart';
import 'package:awesome_webshop/models/winkelmand_product.dart';
import 'package:flutter/material.dart';

class Winkelmandje extends ChangeNotifier {

  List<WinkelmandProduct> productenInMandje = [];

  void addProduct(Product product) {
    Iterable<WinkelmandProduct> existingProduct = productenInMandje.where((wwProduct) => wwProduct.product.id == product.id);
    if (existingProduct.isNotEmpty) {
      print('item bestaat al, increase count');
      increaseCountOfProduct(productenInMandje.indexWhere((element) => element.product.id == product.id));
    } else {
      productenInMandje.add(WinkelmandProduct(product));
      notifyListeners();
    }
  }

  void emptyWinkelmandje() {
    productenInMandje = [];
    notifyListeners();
  }


  void deleteProduct(WinkelmandProduct product) {
    productenInMandje.remove(product);
    notifyListeners();
  }

  void increaseCountOfProduct(int productIndex) {
    productenInMandje[productIndex].increaseCount();
    notifyListeners();
  }

  void decreaseCountOfProduct(int productIndex) {
    productenInMandje[productIndex].decreaseCount();
    notifyListeners();
  }

  void setCountOfProduct(int productIndex, int newCount) {
    productenInMandje[productIndex].setCount(newCount);
    notifyListeners();
  }

  String getTotaalPrice() {
    double price = 0;
    for(WinkelmandProduct wmP in productenInMandje) {
      price += wmP.getPriceWithCount();
    }
    return '€ ${price.toStringAsFixed(2).replaceFirst('.', ',')}';
  }
}