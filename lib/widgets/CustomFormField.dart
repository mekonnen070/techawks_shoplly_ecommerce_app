import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key? key,
    required this.hintText,
    this.initialValue,
    this.onChange,
    this.inputFormatters,
    this.validator,
    this.controller,
  }) : super(key: key);
  String hintText = "";
  String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function(String value)? onChange;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          inputFormatters: inputFormatters,
          validator: validator,
          onChanged: onChange,
          decoration: InputDecoration(
            hintText: hintText,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.black)),
          ),
        ),
      ],
    );
  }
}
