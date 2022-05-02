import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:techawks_shoplly_ecommerce_app/Schemas/get_task_schema.dart';
import 'package:techawks_shoplly_ecommerce_app/constants/constants.dart';
import 'package:techawks_shoplly_ecommerce_app/helper/customAppBar.dart';
import 'package:techawks_shoplly_ecommerce_app/helper/default_button.dart';
import 'package:techawks_shoplly_ecommerce_app/model/products.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/cart/checkoutRoomCart.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/cart/components/cartCard.dart';

class CartHome extends StatefulWidget {
  const CartHome({Key? key}) : super(key: key);

  @override
  State<CartHome> createState() => _CartHomeState();
}

class _CartHomeState extends State<CartHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
              title: 'Continue Shopping',
            ),
            body: Query(
              options: QueryOptions(
                document: gql(GetSchema.getProductsQuery),
              ),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }

                if (result.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                List? categories = result.data?['categories'];

                if (categories == null) {
                  return const Text('No categories');
                }

                return ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Your Cart',
                        style: kBoldTextStyle,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      controller: ScrollController(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final product = result.data?['categories'][index]
                            ['products'][index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.00),
                          child: CartCard(product: product, index: index),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Center(
                        child: DefaultButton(
                          isAdded: false,
                          text: 'Process to Checkout',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const CheckoutRoomCart()));
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            )));
  }
}
