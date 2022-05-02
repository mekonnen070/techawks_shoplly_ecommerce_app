import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:techawks_shoplly_ecommerce_app/helper/default_button.dart';
import 'package:techawks_shoplly_ecommerce_app/model/products.dart';

class ItemCard extends StatefulWidget {
  ItemCard({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  dynamic product;
  int? index;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    print(widget.index);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 35.w,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.network(
                        widget.product['images'][widget.index]['url']),
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
                      '20%',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  )
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
                    widget.product['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "\$${widget.product['price']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DefaultButton(
                    text: isAdded ? "Added" : "Add to Cart",
                    isAdded: isAdded,
                    onPressed: () {
                      setState(() {
                        isAdded = !isAdded;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
