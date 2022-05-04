import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techawks_shoplly_ecommerce_app/constants/constants.dart';

import 'package:techawks_shoplly_ecommerce_app/model/product.dart';
import 'package:techawks_shoplly_ecommerce_app/provider/CartProvider.dart';

class AddToCartButton extends StatelessWidget {
  bool isInCart;
  Product product;

  AddToCartButton({
    Key? key,
    required this.isInCart,
    required this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    final text = isInCart ? 'ADDED' : 'ADD TO CART';

    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1, color: Colors.grey)),
        primary: Colors.white,
        backgroundColor: isInCart ? bgColor : Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
      ),
      onPressed: isInCart
          ? () {
              cartProvider.removeAnItem(product);
            }
          : () {
              cartProvider.addNewItem(product);
            },
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: isInCart ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
