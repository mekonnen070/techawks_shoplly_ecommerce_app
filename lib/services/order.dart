import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:techawks_shoplly_ecommerce_app/Schemas/GetSchema.dart';
import 'package:techawks_shoplly_ecommerce_app/Utils/client.dart';
import 'package:techawks_shoplly_ecommerce_app/model/order.dart';

class OrderService {
  static Future<CreatedOrder?> createOrder(OrderInput orderInput) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(GetSchema.createOrderQuery),
          variables: {"input": orderInput.toJson()});

      QueryResult response = await client.value.mutate(options);
      if (response.data != null) {
        return CreateOrderResult.fromJson(response.data!).createOrder;
      } else {
        // return throw Error;
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }
}
