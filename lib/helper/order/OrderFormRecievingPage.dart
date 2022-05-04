import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:techawks_shoplly_ecommerce_app/Utils/sharedPreferences.dart';
import 'package:techawks_shoplly_ecommerce_app/model/order.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/order/order_loading.dart';
import 'package:techawks_shoplly_ecommerce_app/widgets/CustomFormField.dart';

extension on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != "";
  }
}

class OrderForm extends StatefulWidget {
  const OrderForm({Key? key}) : super(key: key);

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  bool isSave = false;
  String email = "",
      firstName = "",
      lastName = "",
      add1 = "",
      add2 = "",
      city = "",
      country = "",
      zip = "";

  TextEditingController emController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController add1Controller = TextEditingController();
  TextEditingController add2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  void loadFormData() async {
    OrderSharedPreference orderInfoPreference = OrderSharedPreference();
    IOrderForm iOrderForm = await orderInfoPreference.getOrderInfo();
    setState(() {
      emController.text = iOrderForm.email;
      firstNameController.text = iOrderForm.firstName;
      lastNameController.text = iOrderForm.lastName;
      add1Controller.text = iOrderForm.add1;
      add2Controller.text = iOrderForm.add2;
      cityController.text = iOrderForm.city;
      countryController.text = iOrderForm.country;
      zipController.text = iOrderForm.zip;
    });
  }

  void onOrder(BuildContext context) async {
    bool isValid = _formKey.currentState!.validate();
    OrderSharedPreference orderInfoPreference = OrderSharedPreference();
    IOrderForm orderForm = IOrderForm(
      email: email,
      firstName: firstName,
      lastName: lastName,
      add1: add1,
      add2: add2,
      city: city,
      country: country,
      zip: zip,
    );
    if (isSave) {
      await orderInfoPreference.setOrdreInfo(orderForm);
    }
    if (isValid) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return OrderLoading(
          orderForm: orderForm,
        );
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    loadFormData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Contact Information",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomFormField(
            hintText: 'Email or Phone Number',
            controller: emController,
            initialValue: email,
            validator: (val) {
              if (!val!.isValidEmail) return 'Enter valid email';
              return null;
            },
            onChange: (value) {
              setState(() {
                email = value;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Shipping Address",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomFormField(
            hintText: 'First Name',
            controller: firstNameController,
            validator: (val) {
              if (!val!.isNotNull) return 'First Name';
              return null;
            },
            onChange: (value) {
              setState(() {
                firstName = value;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            hintText: 'Last Name',
            controller: lastNameController,
            validator: (val) {
              if (!val!.isNotNull) return 'Last Name';
              return null;
            },
            onChange: (value) {
              setState(() {
                lastName = value;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            hintText: 'Address Line 1',
            controller: add1Controller,
            validator: (val) {
              if (!val!.isNotNull) return 'Enter Address Line 1';
              return null;
            },
            onChange: (value) {
              setState(() {
                add1 = value;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            hintText: 'Address Line 2',
            controller: add2Controller,
            initialValue: add2,
            validator: (val) {
              if (!val!.isNotNull) return 'Enter Your Address 2';
              return null;
            },
            onChange: (value) {
              setState(() {
                add2 = value;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            hintText: 'City/Town',
            controller: cityController,
            validator: (val) {
              if (!val!.isNotNull) return 'Enter Your city';
              return null;
            },
            onChange: (value) {
              setState(() {
                city = value;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            hintText: 'Country',
            controller: countryController,
            validator: (val) {
              if (!val!.isNotNull) return 'Enter Your country';
              return null;
            },
            onChange: (value) {
              setState(() {
                country = value;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormField(
            hintText: 'Postal/Zip',
            controller: zipController,
            validator: (val) {
              if (!val!.isNotNull) return 'Enter Postal or Zip';
              return null;
            },
            onChange: (value) {
              setState(() {
                zip = value;
              });
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: isSave,
                  splashRadius: 0,
                  side: BorderSide(color: Colors.grey.shade300, width: 1),
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.all(Colors.black),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  onChanged: (value) {
                    setState(() {
                      isSave = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              const Text(
                "Save this information for next time",
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: const Text(
                  "COMPLETE ORDER",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              onPressed: () => onOrder(context),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
                  alignment: Alignment.center),
            ),
          )
        ]),
      ),
    );
  }
}
