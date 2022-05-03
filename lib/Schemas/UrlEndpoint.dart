import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:techawks_shoplly_ecommerce_app/Utils/url.dart';

class EndPoint {
  ValueNotifier<GraphQLClient> getClient() {
    ValueNotifier<GraphQLClient> _client = ValueNotifier(GraphQLClient(
      link: HttpLink(endpointUrl),
      cache: GraphQLCache(store: InMemoryStore()),
    ));

    return _client;
  }
}
