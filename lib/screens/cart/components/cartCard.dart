import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:techawks_shoplly_ecommerce_app/constants/constants.dart';
import 'package:techawks_shoplly_ecommerce_app/provider/CartProvider.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.selectedItem,
  }) : super(key: key);

  final CartItem selectedItem;

  @override
  State<CartCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<CartCard> {
  int selectedAmount = 1;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Card(
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1),
        )),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      height: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: widget.selectedItem.product.images[0].url!,
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
                    const SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.selectedItem.product.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.selectedItem.product.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                          onTap: () => cartProvider
                              .removeAnItem(widget.selectedItem.product),
                          child: SvgPicture.asset("assets/icons/remove.svg")),
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              )),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (widget.selectedItem.itemCount > 1) {
                              cartProvider.deductAdddedQuantity(
                                  widget.selectedItem.product);
                            }
                          },
                          child: SvgPicture.asset("assets/Icons/minus.svg"),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          widget.selectedItem.itemCount.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () => cartProvider
                              .addNewQuantity(widget.selectedItem.product),
                          child: SvgPicture.asset("assets/Icons/add.svg"),
                        ),
                      ],
                    ),
                    Text(
                      "\$${(widget.selectedItem.itemCount * widget.selectedItem.product.price).toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

    Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
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
                    child: CachedNetworkImage(
                      imageUrl: widget.selectedItem.product.images[0].url!,
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
                ),
                const SizedBox(width: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.selectedItem.product.name,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: kBoldTextStyle,
                        ),
                        Text(
                          widget.selectedItem.product.description,
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            // fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    kHorizontalSpacer,
                    kHorizontalSpacer,
                    InkWell(
                      onTap: () {
                        cartProvider.removeAnItem(widget.selectedItem.product);
                      },
                      child: SvgPicture.asset(
                        'assets/Icons/remove.svg',
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          if (widget.selectedItem.itemCount > 1) {
                            cartProvider.deductAdddedQuantity(
                                widget.selectedItem.product);
                          }
                        },
                        child: SvgPicture.asset('assets/Icons/minus.svg')),
                    kHorizontalSpacer,
                    Text(
                      selectedAmount.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    kHorizontalSpacer,
                    InkWell(
                        onTap: () {
                          cartProvider
                              .addNewQuantity(widget.selectedItem.product);
                        },
                        child: SvgPicture.asset('assets/Icons/add.svg')),
                  ],
                ),
                Text(
                  "\$${(widget.selectedItem.itemCount * widget.selectedItem.product.price).toStringAsFixed(2)}",
                  style: kBoldTextStyle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
