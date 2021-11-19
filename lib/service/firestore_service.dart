

import 'package:awesome_webshop/models/order.dart';
import 'package:awesome_webshop/models/product.dart';
import 'package:awesome_webshop/models/winkelmandje.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';
final _firestore = FirebaseFirestore.instance;

class FirestoreService {
  static FirestoreService instance = FirestoreService();

  Future<List<Product>> getAllProducts() async {
    List<Product> products = [];
    var collection = _firestore.collection('products');
    var querySnapshot = await collection.get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      Product product = Product(
          data['title'],
          data['shortDescription'],
          data['description'],
          data['price'],
          data['imgBase64'],
          data['color']);
      product.id = doc.id;
      products.add(product);
    }
    return products;
  }


  Future<List<Order>> getAllOrders() async {
    List<Order> orders = [];
    var collection = _firestore.collection('orders').where('userEmail', isEqualTo: AuthService.instance.auth.currentUser!.email);
    var querySnapshot = await collection.get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      Order order = Order(
          data['userEmail'],
          data['totalAmount'],
          data['timeStamp']);
      orders.add(order);
    }
    return orders;
  }

  Future<bool> doeAdminExist() async {
    var collection = _firestore.collection('admins').where('adminEmail', isEqualTo: AuthService.instance.auth.currentUser!.email);
    var querySnapshot = await collection.get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> confirmShoppingCart(Winkelmandje winkelmandje) async {
    CollectionReference orders = FirebaseFirestore.instance.collection('orders');
    await orders.add({
      'userEmail': AuthService.instance.auth.currentUser!.email,
      'timeStamp': DateTime.now(),
      'totalAmount': winkelmandje.getTotaalPrice()
    });
  }

  Future<void> addProduct(Product product) async {
    CollectionReference products = FirebaseFirestore.instance.collection('products');
    await products.add({
      'title' : product.title,
      'shortDescription' : product.shortDescription,
      'description' : product.description,
      'price' : product.price,
      'imgBase64': product.imgBase64,
      'color': product.color,
    });
  }


}
