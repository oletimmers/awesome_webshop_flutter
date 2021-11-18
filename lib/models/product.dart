import 'dart:convert';

import 'package:flutter/material.dart';

class Product {
  String title;
  String shortDescription;
  String description;
  double price;
  String imgBase64;
  String color;
  String id = "";

  Product(this.title, this.shortDescription, this.description, this.price, this.imgBase64, this.color);


  MemoryImage getImage() {
    return MemoryImage(base64Decode(imgBase64));
  }

  String getPriceFormatted() {
    return '€ ${price.toString().replaceFirst('.', ',')}';
  }
}