import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:techawks_shoplly_ecommerce_app/Schemas/GetSchema.dart';
import 'package:techawks_shoplly_ecommerce_app/Schemas/UrlEndpoint.dart';
import 'package:techawks_shoplly_ecommerce_app/model/product.dart';

class GetProductProvider extends ChangeNotifier {
  bool _status = false;

  String _response = '';

  bool get getStatus => _status;

  int selectedIndexNode = 0;

  set changeSelectedIndexNode(selectedIndexNode) {
    this.selectedIndexNode = selectedIndexNode + 1;
  }

  String get getResponse => _response;

  Future getProduct() async {
    ValueNotifier<GraphQLClient> _client = EndPoint.getClient();

    QueryResult result = await _client.value.query(QueryOptions(
      document: gql(GetSchema.getProductsQuery),
    ));

    if (result.hasException) {
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = "Internet is not found";
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      _status = false;
      notifyListeners();
      return result.data;
    }
  }
}

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
