import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:techawks_shoplly_ecommerce_app/Schemas/GetSchema.dart';
import 'package:techawks_shoplly_ecommerce_app/Utils/PriceCalcultor.dart';
import 'package:techawks_shoplly_ecommerce_app/constants/constants.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/cart/components/cartCard.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/order/order_screen.dart';
import 'package:techawks_shoplly_ecommerce_app/widgets/customAppBar.dart';
import 'package:techawks_shoplly_ecommerce_app/widgets/default_button.dart';

import '../../provider/CartProvider.dart';

class CartHome extends StatefulWidget {
  const CartHome({Key? key}) : super(key: key);

  @override
  State<CartHome> createState() => _CartHomeState();
}

class _CartHomeState extends State<CartHome> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
              title: 'Continue Shopping',
            ),
            body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Your Cart',
                          style: kBoldTextStyle,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartProvider.items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: CartCard(
                                  selectedItem: cartProvider.items[index]),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                            border: Border(
                          top:
                              BorderSide(color: Colors.grey.shade300, width: 1),
                        )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "TOTAL INCL. TAX",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "\$${Price.calculateTotalPrice(cartProvider.items).toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Center(
                          child: DefaultButton(
                            isAdded: false,
                            text: 'PROCCESS TO CHECKOUT',
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const OrderScreen()));
                            },
                          ),
                        ),
                      ),
                    ],
                  ));
            })));
  }
}
