// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:techawks_shoplly_ecommerce_app/model/product.dart';
import 'package:techawks_shoplly_ecommerce_app/provider/CartProvider.dart';
import 'package:techawks_shoplly_ecommerce_app/shimmers/product_item_shimmer.dart';
import 'package:techawks_shoplly_ecommerce_app/widgets/AddToCatButton.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final List<Product> products;
  ItemCard(
      {Key? key,
      this.loading = false,
      required this.product,
      required this.products})
      : super(key: key);

  bool isAdded = false;
  bool loading = false;

  bool isAlreadyProductInCart(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    bool isProductInCart = false;
    for (var item in cartProvider.items) {
      if (item.productId == product.productId) {
        isProductInCart = true;
      }
    }

    return isProductInCart;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: ProductItemShimmer());
    }

    if (products.isEmpty) {
      return const Center(
        child: Text(
          "No Product",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 30.w,
              height: 17.h,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.images[0].url!,
                      imageBuilder: (context, imageProvider) => Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SvgPicture.asset(
                      'assets/Icons/discount.svg',
                      height: 38,
                    ),
                  ),
                  Positioned(
                    top: 9,
                    left: 9,
                    child: Text(
                      product.discount.toString() + '%',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AddToCartButton(
                      isInCart: isAlreadyProductInCart(context),
                      product: product)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
