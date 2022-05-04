import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techawks_shoplly_ecommerce_app/model/order.dart';
import 'package:techawks_shoplly_ecommerce_app/provider/CartProvider.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/order/order_complete.dart';
import 'package:techawks_shoplly_ecommerce_app/services/order.dart';

class OrderLoading extends StatefulWidget {
  const OrderLoading({Key? key, required this.orderForm}) : super(key: key);
  final IOrderForm orderForm;

  @override
  State<OrderLoading> createState() => _OrderLoadingState();
}

class _OrderLoadingState extends State<OrderLoading> {
  bool loading = true;
  void onOrder(
      BuildContext context, IOrderForm orderForm, List<CartItem> items) async {
    List<OrderItemInput> orderItems = [];
    for (var item in items) {
      orderItems.add(OrderItemInput(
          orderId: "", productId: item.productId, quantity: item.itemCount));
    }
    CreatedOrder? res = await OrderService.createOrder(OrderInput(
        customerEmailPhone: orderForm.email,
        customerFullName: orderForm.firstName + orderForm.lastName,
        customerAddress1: orderForm.add1,
        customerAddress2: orderForm.add2,
        customerCity: orderForm.city,
        country: orderForm.country,
        zipCode: orderForm.zip,
        orderItems: orderItems));
    if (res != null) {
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return OrderCompleteScreen(
          orderNumber: res.orderNumber,
          deliveryDate: res.deliveryDate,
          shipingDetail:
              "${orderForm.firstName} ${orderForm.lastName} ${orderForm.city} ${orderForm.country} ",
        );
      }));

      return;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    onOrder(context, widget.orderForm, cartProvider.items);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: loading,
              child: const CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Your order is being",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const Text(
              "processed.",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
