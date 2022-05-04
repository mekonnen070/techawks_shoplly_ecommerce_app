import 'package:flutter/material.dart';
import 'package:techawks_shoplly_ecommerce_app/Utils/PriceCalcultor.dart';
import 'package:techawks_shoplly_ecommerce_app/helper/order/OrderSUmmaryBuilderCardPage.dart';
import 'package:techawks_shoplly_ecommerce_app/provider/CartProvider.dart';

class CompleteOrderSummary extends StatelessWidget {
  const CompleteOrderSummary(
      {Key? key,
      required this.orderNumber,
      required this.deliveryDate,
      required this.items,
      required this.shipingDetail})
      : super(key: key);
  final String orderNumber, deliveryDate, shipingDetail;
  final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Order Summary",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Divider(color: Colors.grey.shade300, height: 1),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1))),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 190,
                    child: Text(
                      "ORDER NO",
                      style:
                          TextStyle(color: Colors.grey.shade400, fontSize: 18),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      orderNumber,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 190,
                    child: Text(
                      "EST DELIVERY DATE",
                      style:
                          TextStyle(color: Colors.grey.shade400, fontSize: 18),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      deliveryDate,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 190,
                    child: Text(
                      "SHIPPING DETAILS",
                      style:
                          TextStyle(color: Colors.grey.shade400, fontSize: 18),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      shipingDetail,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
        SizedBox(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return OrderSummaryItem(item: items[index]);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOTAL",
                style: TextStyle(color: Colors.grey.shade400, fontSize: 18),
              ),
              Text(
                "\$${(Price.calculateTotalPrice(items).toStringAsFixed(2))}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              )
            ],
          ),
        )
      ]),
    );
  }
}
