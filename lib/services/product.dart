import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shoplly/client.dart';
import 'package:shoplly/graphql/products.dart';
import 'dart:developer' as dev;

import 'package:shoplly/model/product.dart';

class ProductService {
  static Future<List<Product>?> products(String categoryId) async {
    try {
      QueryOptions options = QueryOptions(
          document: gql(productsDocument),
          variables: {"categoryId": categoryId});

      QueryResult response = await client.value.query(options);
      if (response.data != null) {
        return ProductsResult.fromJson(response.data!).products;
      } else {
        return throw Error;
      }
    } catch (e) {
      dev.log(e.toString());
    }

    return null;
  }
}
