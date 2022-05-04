import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

HttpLink httpLink = HttpLink('https://shoplly-api.techawks.io/graphql');

final AuthLink authLink = AuthLink(
  getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
);

final Link link = authLink.concat(httpLink);

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: link,
    cache: GraphQLCache(store: InMemoryStore()),
  ),
);
