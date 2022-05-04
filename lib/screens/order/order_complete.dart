import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:techawks_shoplly_ecommerce_app/helper/order/ThanksForShoppingPage.dart';
import 'package:techawks_shoplly_ecommerce_app/provider/CartProvider.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/home/home.dart';
import 'package:techawks_shoplly_ecommerce_app/widgets/customAppBar.dart';

class OrderCompleteScreen extends StatelessWidget {
  const OrderCompleteScreen(
      {Key? key,
      required this.orderNumber,
      required this.deliveryDate,
      // required this.items,
      required this.shipingDetail})
      : super(key: key);
  final String orderNumber, deliveryDate, shipingDetail;
  // final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SvgPicture.asset("assets/Icons/success.svg"),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Thank you for",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              "shopping with Shoplly.",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Your orders are on the way.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: const Text(
                    "BACK TO SHOPPING",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                onPressed: () {
                  cartProvider.removeAll();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const ProductTabHomePage()),
                      (Route<dynamic> route) => false);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30))),
                    alignment: Alignment.center),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CompleteOrderSummary(
                orderNumber: orderNumber,
                shipingDetail: shipingDetail,
                deliveryDate: deliveryDate,
                items: cartProvider.items),
          ]),
        ),
      ),
    );
  }
}
