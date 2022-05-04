import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techawks_shoplly_ecommerce_app/Utils/PriceCalcultor.dart';
import 'package:techawks_shoplly_ecommerce_app/helper/order/OrderSUmmaryBuilderCardPage.dart';
import 'package:techawks_shoplly_ecommerce_app/provider/CartProvider.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary>
    with SingleTickerProviderStateMixin {
  bool isExpand = true;

  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return GestureDetector(
        onTap: () {
          if (isExpand) {
            expandController.forward();
          } else {
            expandController.reverse();
          }
          setState(() {
            isExpand = !isExpand;
          });
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(246, 246, 246, 1),
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300, width: 1),
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                  )),
              child: Row(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.grey.shade400,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "Show order summary",
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Transform.rotate(
                    angle: !isExpand
                        ? -90 * pi / 180
                        : 90 * pi / 180, //set the angel
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade400,
                      size: 24,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "\$${Price.calculateTotalPrice(cartProvider.items).toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              child: SizeTransition(
                axisAlignment: 1.0,
                sizeFactor: animation,
                // visible: isExpand,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    return Container(
                        color: const Color.fromRGBO(246, 246, 246, 1),
                        child:
                            OrderSummaryItem(item: cartProvider.items[index]));
                  },
                ),
              ),
            )
          ],
        ));
  }
}
