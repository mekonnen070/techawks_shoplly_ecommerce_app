import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(30)),
  borderSide: BorderSide(
    width: 1,
    color: Colors.grey.withOpacity(0.7),
  ),
);

class SearchField extends StatelessWidget {
  SearchField({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Form(
        key: _formKey,
        child: TextFormField(
          onSaved: (value) {},
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 5),
            hintText: "Search products",
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset("assets/Icons/search.svg"),
            ),
          ),
        ),
      ),
    );
  }
}
