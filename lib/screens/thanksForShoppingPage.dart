import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techawks_shoplly_ecommerce_app/constants/constants.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/home/home.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/orderProccesdingPage.dart';

class OrderSummary extends StatelessWidget {
  final String leadingText;

  final String trailingText;
  const OrderSummary({
    Key? key,
    required this.leadingText,
    required this.trailingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leadingText,
          style: kBoldTextStyle.copyWith(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(
          width: 30,
        ),
        Flexible(
          child: Text(
            trailingText,
            maxLines: 5,
            overflow: TextOverflow.visible,
            style: kBoldTextStyle.copyWith(fontSize: 16),
          ),
        )
      ],
    );
  }
}

class ThanksForShoppingPage extends StatefulWidget {
  const ThanksForShoppingPage({Key? key}) : super(key: key);

  @override
  State<ThanksForShoppingPage> createState() => _ThanksForShoppingPageState();
}

class _ThanksForShoppingPageState extends State<ThanksForShoppingPage> {
  bool waitingIsOver = false;

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    totalPrice = double.parse(totalPrice.toStringAsFixed(2));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/Icons/arrow_left.svg',
                  color: Colors.black,
                ),
              ),
            ),
          ),
          title: SvgPicture.asset(
            'assets/Icons/logo.svg',
          ),
          centerTitle: true,
        ),
        body: waitingIsOver
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: SvgPicture.asset(
                          'assets/Icons/success.svg',
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Thank you for shopping with Shoplly.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          'Your orders are on the way.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FittedBox(
                        child: SizedBox(
                          height: 40,
                          width: 300,
                          child: OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(
                                  side: BorderSide(color: Colors.black)),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const MyHomePage()));
                            },
                            child: const Text(
                              'Back to Shopping',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Order Summary',
                          style: kBoldTextStyle,
                        ),
                      ),
                      const Divider(),
                      const OrderSummary(
                        leadingText: 'ORDER SUMMARY',
                        trailingText: '568464',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const OrderSummary(
                        leadingText: 'EST DELIVERY DATE',
                        trailingText: '18 APRIL, 2022',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const OrderSummary(
                        leadingText: 'SHIIPING DETAILS',
                        trailingText:
                            'PAUL WRITERR AFRICA ANV ST, ADDIS ABABA, ETHIOPIA',
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 8,
                      ),
                      const OrderSummary(
                        leadingText: 'TOTAL',
                        trailingText: '\$ 4525.53',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              )
            : const OrderProccessingPage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    waitAMinute();
  }

  Future waitAMinute() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      waitingIsOver = true;
    });
  }
}
