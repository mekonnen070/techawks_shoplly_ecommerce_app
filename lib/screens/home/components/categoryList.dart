// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:techawks_shoplly_ecommerce_app/Schemas/get_task_schema.dart';
import 'package:techawks_shoplly_ecommerce_app/constants/constants.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/home/home.dart';

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
  List? categories;
  CategoriesList({
    Key? key,
    this.categories,
  }) : super(key: key);
}

class _CategoriesListState extends State<CategoriesList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.categories!.length,
          itemBuilder: (context, index) {
            final category = widget.categories![index]['name'];
            return buildCategory(category, index);
          },
        ),
      ),
    );
  }

  Widget buildCategory(category, index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              category,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            selectedIndex == index
                ? SvgPicture.asset(
                    'assets/Icons/line.svg',
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
