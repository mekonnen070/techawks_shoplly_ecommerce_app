import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:techawks_shoplly_ecommerce_app/model/product.dart';

class CartItem {
  CartItem(
      {required this.productId,
      required this.product,
      required this.itemCount});

  String productId;
  Product product;
  int itemCount;
}

class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  void addNewItem(Product item) {
    _items
        .add(CartItem(productId: item.productId, product: item, itemCount: 1));
    notifyListeners();
  }

  void addNewQuantity(Product item) {
    List<CartItem> addCartQuantity = [];
    for (CartItem cart in items) {
      if (cart.productId == item.productId) {
        addCartQuantity.add(CartItem(
            productId: item.productId,
            product: item,
            itemCount: cart.itemCount + 1));
      } else {
        addCartQuantity.add(cart);
      }
    }
    _items = addCartQuantity;
    notifyListeners();
  }

  void deductAdddedQuantity(Product item) {
    List<CartItem> minusCartQuantity = [];
    for (CartItem cart in items) {
      if (cart.productId == item.productId) {
        minusCartQuantity.add(CartItem(
            productId: item.productId,
            product: item,
            itemCount: cart.itemCount - 1));
      } else {
        minusCartQuantity.add(cart);
      }
    }
    _items = minusCartQuantity;
    notifyListeners();
  }

  void removeAnItem(Product item) {
    _items =
        _items.where((product) => product.productId != item.productId).toList();
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
