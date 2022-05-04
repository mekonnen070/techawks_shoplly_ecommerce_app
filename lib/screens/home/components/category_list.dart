import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techawks_shoplly_ecommerce_app/model/category.dart';
import 'dart:developer' as dev;

import 'package:techawks_shoplly_ecommerce_app/model/sub_category.dart';
import 'package:techawks_shoplly_ecommerce_app/services/category.dart';
import 'package:techawks_shoplly_ecommerce_app/shimmers/category_item_shimmer.dart';

class CategoryList extends StatefulWidget {
  final Function(String catId, List<SubCategory> subCats) onChangeCategory;
  final String selectedCategoryId;

  const CategoryList(
      {Key? key,
      required this.onChangeCategory,
      required this.selectedCategoryId})
      : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<Category>? categories = [];
  bool loading = false;

  void getCategories() async {
    List<Category>? cats = await CategoryService.categories();
    setState(() {
      loading = false;
      categories = cats;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });

    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CategoryItemShimmer(),
      );
    }
    if (categories == null) {
      return const Text("no category");
    }
    return SizedBox(
        width: double.infinity,
        child: ListView.builder(
          itemCount: categories?.length,
          padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            bool isSelected =
                (categories?[index].categoryId == widget.selectedCategoryId)
                    ? true
                    : false;
            TextStyle catNameStyle = TextStyle(
                color: isSelected
                    ? const Color.fromRGBO(0, 0, 0, 1)
                    : const Color.fromRGBO(184, 184, 184, 1),
                fontSize: 20.0);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () => widget.onChangeCategory(
                    categories![index].categoryId,
                    categories![index].subCategories),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(categories![index].name, style: catNameStyle),
                    const SizedBox(
                      height: 6,
                    ),
                    Visibility(
                      visible: isSelected,
                      child: SvgPicture.asset(
                        "assets/Icons/line.svg",
                        height: 4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
