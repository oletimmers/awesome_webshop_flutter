
import 'package:awesome_webshop/models/product.dart';

class WinkelmandProduct{
  final Product product;
  int count = 1;

  WinkelmandProduct(this.product);

  void increaseCount () {
    count ++;
  }
  void decreaseCount () {
    if (count > 1) {
      count --;
    }
  }

  void setCount(int newCount) {
    count = newCount;
  }


  String getPriceFormatted() {
    double priceNow = getPriceWithCount();
    return '€ ${priceNow.toStringAsFixed(2).replaceFirst('.', ',')}';
  }

  double getPriceWithCount() {
    return product.price * count;
  }

}