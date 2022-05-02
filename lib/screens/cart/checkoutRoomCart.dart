// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:techawks_shoplly_ecommerce_app/Schemas/get_task_schema.dart';
import 'package:techawks_shoplly_ecommerce_app/constants/constants.dart';
import 'package:techawks_shoplly_ecommerce_app/helper/customAppBar.dart';
import 'package:techawks_shoplly_ecommerce_app/helper/default_button.dart';
import 'package:techawks_shoplly_ecommerce_app/model/products.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/cart/components/ExpansionTileCard.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/cart/components/cartCard.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/home/components/search_field.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/orderProccesdingPage.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/thanksForShoppingPage.dart';

class CheckoutRoomCart extends StatefulWidget {
  const CheckoutRoomCart({Key? key}) : super(key: key);

  @override
  State<CheckoutRoomCart> createState() => _CheckoutRoomCartState();
}

class _CheckoutRoomCartState extends State<CheckoutRoomCart> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController addLine1Controller = TextEditingController();
  TextEditingController addLine2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController postalZipController = TextEditingController();

  bool isExpansionOpened = false;

  final _formKey = GlobalKey<FormState>();

  bool checkedValue = false;

  QueryResult? cresult;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
              title: 'Cart',
            ),
            body: Query(
                options: QueryOptions(
                  document: gql(GetSchema.getProductsQuery),
                ),
                builder: (QueryResult result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }

                  if (result.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  List? categories = result.data?['categories'];

                  if (categories == null) {
                    return const Text('No Order Summary');
                  }
                  cresult = result;

                  return Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        CustomExpansionTile(),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Contact Information',
                                style: kBoldTextStyle.copyWith(fontSize: 16),
                              ),
                              ContactInfoForm(
                                hintText: 'Email or Phone Number',
                                controller: emailController,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping Address',
                                style: kBoldTextStyle.copyWith(fontSize: 16),
                              ),
                              ContactInfoForm(
                                hintText: 'First Name',
                                controller: fnameController,
                              ),
                              ContactInfoForm(
                                hintText: 'Last Name',
                                controller: lnameController,
                              ),
                              ContactInfoForm(
                                hintText: 'Address Line 1',
                                controller: addLine1Controller,
                              ),
                              ContactInfoForm(
                                hintText: 'Address Line 2',
                                controller: addLine2Controller,
                              ),
                              ContactInfoForm(
                                hintText: 'City/Town',
                                controller: cityController,
                              ),
                              ContactInfoForm(
                                hintText: 'Country',
                                controller: countryController,
                              ),
                              ContactInfoForm(
                                hintText: 'Postal/Zip',
                                controller: postalZipController,
                              ),
                              customCheckBox(),
                              Center(
                                child: DefaultButton(
                                  isAdded: false,
                                  text: 'COMPLETE ORDER',
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const ThanksForShoppingPage()));
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })));
  }

  CheckboxListTile customCheckBox() {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        'Save this information for next time',
        overflow: TextOverflow.ellipsis,
        style: kBoldTextStyle.copyWith(fontSize: 16),
      ),
      value: checkedValue,
      onChanged: (bool? isOn) {
        setState(() {
          checkedValue = isOn!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  ExpansionTile CustomExpansionTile() {
    return ExpansionTile(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isExpansionOpened
                ? const Flexible(
                    child: Text(
                      'Show order summary',
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : const Flexible(
                    child: Text(
                      'Hide order summary',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
            if (!isExpansionOpened)
              const Icon(
                Icons.keyboard_arrow_down_outlined,
              ),
            if (isExpansionOpened) const Icon(Icons.keyboard_arrow_up_outlined)
          ],
        ),
        leading: const Icon(Icons.shopping_cart),
        trailing: Text(
          '\$' + 4527.00.roundToDouble().toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onExpansionChanged: (value) {
          setState(() {
            isExpansionOpened = !isExpansionOpened;
          });
        },
        children: [
          ListView.builder(
            shrinkWrap: true,
            controller: ScrollController(),
            itemCount: 5,
            itemBuilder: (context, index) {
              final product =
                  cresult!.data?['categories'][index]['products'][index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.00),
                child: ExpansionChildrenCard(product: product, index: index),
              );
            },
          ),
        ]);
  }
}

class ContactInfoForm extends StatelessWidget {
  const ContactInfoForm({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  final dynamic controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $hintText';
            }
            return null;
          },
          controller: controller,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
            hintText: hintText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      ],
    );
  }
}
