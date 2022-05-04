import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techawks_shoplly_ecommerce_app/helper/order/OrderFormRecievingPage.dart';
import 'package:techawks_shoplly_ecommerce_app/helper/order/ShowOrderSummaryPage.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        leading: IconButton(
          padding: const EdgeInsets.all(4),
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "CART",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [OrderSummary(), OrderForm()],
        ),
      ),
    );
  }
}
