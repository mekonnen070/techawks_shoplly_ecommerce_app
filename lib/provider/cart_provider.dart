import 'dart:collection';

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

  void add(Product item) {
    _items
        .add(CartItem(productId: item.productId, product: item, itemCount: 1));
    notifyListeners();
  }

  void addQuantity(Product item) {
    List<CartItem> addCartQuantity = [];
    for (CartItem c in items) {
      if (c.productId == item.productId) {
        addCartQuantity.add(CartItem(
            productId: item.productId,
            product: item,
            itemCount: c.itemCount + 1));
      } else {
        addCartQuantity.add(c);
      }
    }
    _items = addCartQuantity;
    notifyListeners();
  }

  void minusQuantity(Product item) {
    List<CartItem> minusCartQuantity = [];
    for (CartItem c in items) {
      if (c.productId == item.productId) {
        minusCartQuantity.add(CartItem(
            productId: item.productId,
            product: item,
            itemCount: c.itemCount - 1));
      } else {
        minusCartQuantity.add(c);
      }
    }
    _items = minusCartQuantity;
    notifyListeners();
  }

  void removeItem(Product item) {
    _items =
        _items.where((product) => product.productId != item.productId).toList();
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
