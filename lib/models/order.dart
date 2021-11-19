import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String userEmail;
  String totalAmount;
  Timestamp timeStamp;

  Order(this.userEmail, this.totalAmount, this.timeStamp);
}