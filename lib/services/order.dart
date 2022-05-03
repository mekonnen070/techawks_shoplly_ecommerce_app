import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shoplly/client.dart';
import 'package:shoplly/graphql/create_order.dart';
import 'package:shoplly/model/order.dart';

class OrderService {
  static Future<CreatedOrder?> createOrder(OrderInput orderInput) async {
    try {
      MutationOptions options = MutationOptions(
          document: gql(createOrderDocument),
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
