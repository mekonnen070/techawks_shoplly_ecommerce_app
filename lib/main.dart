import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:techawks_shoplly_ecommerce_app/constants/constants.dart';
import 'package:techawks_shoplly_ecommerce_app/provider/getProductProvider.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/home/home.dart';

void main() {
  final HttpLink httpLink = HttpLink('https://shoplly-api.techawks.io/graphql');

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );
  var app = GraphQLProvider(
    client: client,
    child: const MyApp(),
  );

  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MultiProvider(
          providers: [
                 ChangeNotifierProvider(create: (_) => GetProductProvider()),
                 ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  elevation: 0.5),
              primarySwatch: Colors.blue,
              backgroundColor: bgColor,
              fontFamily: 'SegUIVar',
            ),
            home: const MyHomePage(),
          ),
        );
      },
    );
  }
}
