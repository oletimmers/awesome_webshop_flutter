

import 'package:awesome_webshop/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
}
