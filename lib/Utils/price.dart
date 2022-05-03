import 'package:shoplly/provider/cart_provider.dart';

class Price{
  static int calculateTotalPrice(List<CartItem> items) {
    int totalPrice = 0;
    for (CartItem c in items) {
      totalPrice += c.itemCount * c.product.price;
    }

    return totalPrice;
  }
}