import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:techawks_shoplly_ecommerce_app/Schemas/GetSchema.dart';
import 'package:techawks_shoplly_ecommerce_app/Schemas/UrlEndpoint.dart';
import 'dart:developer' as dev;

import 'package:techawks_shoplly_ecommerce_app/model/category.dart';

class CategoryService {
  static Future<List<Category>?> categories() async {
    try {
      QueryOptions options =
          QueryOptions(document: gql(GetSchema.getProductsQuery));

      QueryResult response = await EndPoint.getClient().value.query(options);
      if (response.data != null) {
        return CategoriesResult.fromJson(response.data!).categories;
      } else {
        return throw Error;
      }
    } catch (e) {
      dev.log(e.toString());
    }

    return null;
  }
}
