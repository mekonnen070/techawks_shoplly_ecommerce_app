import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:techawks_shoplly_ecommerce_app/Schemas/get_task_schema.dart';
import 'package:techawks_shoplly_ecommerce_app/Schemas/urlEndpoint.dart';

class GetProductProvider extends ChangeNotifier {
  bool _status = false;

  String _response = '';

  bool get getStatus => _status;

  int selectedIndexNode = 0;

  set changeSelectedIndexNode(selectedIndexNode) {
    this.selectedIndexNode = selectedIndexNode + 1;
  }

  String get getResponse => _response;

  final EndPoint _point = EndPoint();

  Future getProduct() async {
    ValueNotifier<GraphQLClient> _client = _point.getClient();

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
