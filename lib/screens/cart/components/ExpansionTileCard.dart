import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:techawks_shoplly_ecommerce_app/model/products.dart';

import '../../../constants/constants.dart';

class ExpansionChildrenCard extends StatelessWidget {
  const ExpansionChildrenCard({Key? key, required this.product})
      : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 30.w,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(product.images[0]),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: kBoldTextStyle,
                      ),
                      Text(
                        product.description,
                        maxLines: 2,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
                kHorizontalSpacer,
                kHorizontalSpacer,
                Text(
                  '\$' + product.price.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
