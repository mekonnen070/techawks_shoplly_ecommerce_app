import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:techawks_shoplly_ecommerce_app/provider/CartProvider.dart';

class OrderSummaryItem extends StatelessWidget {
  OrderSummaryItem({Key? key, required this.item}) : super(key: key);

  CartItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 25.h,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        )),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            width: 30.w,
            height: double.infinity,
            child: CachedNetworkImage(
              imageUrl: item.product.images[0].url!,
              imageBuilder: (context, imageProvider) => Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  item.product.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            "\$${(item.itemCount * item.product.price).toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )
        ]),
      ),
    );
  }
}
