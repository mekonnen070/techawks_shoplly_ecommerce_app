import 'package:flutter/material.dart';
import 'package:techawks_shoplly_ecommerce_app/constants/constants.dart';

class OrderProccessingPage extends StatelessWidget {
  const OrderProccessingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(child: CircularProgressIndicator.adaptive()),
          SizedBox(
            height: 10,
          ),
          Text(
            'Your order is being processed',
            // textAlign: TextAlign.center,
            style: kBoldTextStyle,
          ),
        ],
      ),
    );
  }
}
