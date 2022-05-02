import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:techawks_shoplly_ecommerce_app/constants/constants.dart';
import 'package:techawks_shoplly_ecommerce_app/helper/default_button.dart';
import 'package:techawks_shoplly_ecommerce_app/model/products.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  final dynamic product;
  final num index;

  @override
  State<CartCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<CartCard> {
  int selectedAmount = 1;

  @override
  Widget build(BuildContext context) {
    double priceOfSelectedItem =
        double.tryParse(widget.product['price'].toString())! * selectedAmount;
    return Card(
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
                    child: Image.network(
                        widget.product['images'][widget.index]['url']),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.product['name'],
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: kBoldTextStyle,
                            ),
                            Text(
                              widget.product['description'],
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
                      ),
                      kHorizontalSpacer,
                      kHorizontalSpacer,
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/Icons/remove.svg',
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
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
                          if (selectedAmount != 1) {
                            setState(() {
                              selectedAmount -= 1;
                            });
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
                          setState(() {
                            selectedAmount += 1;
                          });
                        },
                        child: SvgPicture.asset('assets/Icons/add.svg')),
                  ],
                ),
                Text(
                  '\$' +
                      double.parse(priceOfSelectedItem.toString())
                          .toStringAsFixed(2),
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
