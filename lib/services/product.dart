import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:techawks_shoplly_ecommerce_app/Schemas/GetSchema.dart';

import 'dart:developer' as dev;
import 'package:techawks_shoplly_ecommerce_app/Utils/client.dart';
import 'package:techawks_shoplly_ecommerce_app/model/product.dart';

class ProductService {
  static Future<List<Product>?> products(String categoryId) async {
    try {
      QueryOptions options = QueryOptions(
          document: gql(GetSchema.productsQuery),
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
