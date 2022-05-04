import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techawks_shoplly_ecommerce_app/provider/CartProvider.dart';

class CartItemLength extends StatelessWidget {
  const CartItemLength({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [
            Color.fromRGBO(0, 203, 255, 1),
            Color.fromRGBO(214, 41, 255, 1),
          ])),
      child: Text(
        cartProvider.items.length.toString(),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
