import 'dart:collection';

import 'package:awesome_webshop/models/product.dart';
import 'package:flutter/material.dart';

class Winkelmandje extends ChangeNotifier {

  final List<WinkelmandProduct> productenInMandje = [];

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


  void deleteProduct(WinkelmandProduct product) {
    productenInMandje.remove(product);
    notifyListeners();
  }

  void increaseCountOfProduct(int productIndex) {
    productenInMandje[productIndex].increaseCount();
    notifyListeners();
  }

  void setCountOfProduct(int productIndex, int newCount) {
    productenInMandje[productIndex].setCount(newCount);
    notifyListeners();
  }
  
  

}

class WinkelmandProduct{
  final Product product;
  int count = 1;
  
  WinkelmandProduct(this.product);
  
  void increaseCount () {
    count ++;
  }
  
  void setCount(int newCount) {
    count = newCount;
  }


}