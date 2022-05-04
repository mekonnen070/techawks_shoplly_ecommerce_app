import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:techawks_shoplly_ecommerce_app/model/sub_category.dart';

enum Sort { discounts, bestSelling, priceLowToHigh, priceHighToLow }

class FilterSortScreen extends StatefulWidget {
  const FilterSortScreen(
      {Key? key,
      required this.subCategories,
      required this.selectedSort,
      required this.onSort,
      required this.selectedFilters,
      required this.onClear,
      required this.onFilter})
      : super(key: key);
  final List<SubCategory> subCategories;
  final List<String> selectedFilters;
  final Function(Sort sort) onSort;
  final Function() onClear;
  final Function(String subCatId) onFilter;
  final Sort? selectedSort;

  @override
  _FilterSortScreenState createState() => _FilterSortScreenState();
}

class _FilterSortScreenState extends State<FilterSortScreen> {
  Sort? _sort;

  @override
  void initState() {
    super.initState();
    _sort = widget.selectedSort;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        leading: IconButton(
          padding: const EdgeInsets.all(4),
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Filter & Sort",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _sort = null;
                  });
                  widget.onClear();
                },
                child: const Text(
                  'Clear',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
          ),
          child: Column(children: [
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.subCategories.length,
                  itemBuilder: (context, index) {
                    return FilterItem(
                      onFilter: widget.onFilter,
                      selectedFilters: widget.selectedFilters,
                      subCategory: widget.subCategories[index],
                    );
                  }),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.grey.shade300, width: 1))),
              child: const Text(
                "SORT",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text(
                    'Discount',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  horizontalTitleGap: 8,
                  leading: SizedBox(
                    width: 24,
                    height: 24,
                    child: Radio<Sort>(
                      fillColor: MaterialStateProperty.all(Colors.black),
                      value: Sort.discounts,
                      groupValue: _sort,
                      onChanged: (Sort? value) {
                        setState(() {
                          _sort = value;
                          widget.onSort(value!);
                        });
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Best Selling',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  horizontalTitleGap: 8,
                  leading: SizedBox(
                    width: 24,
                    height: 24,
                    child: Radio<Sort>(
                      fillColor: MaterialStateProperty.all(Colors.black),
                      value: Sort.bestSelling,
                      groupValue: _sort,
                      onChanged: (Sort? value) {
                        setState(() {
                          _sort = value;
                          widget.onSort(value!);
                        });
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Price, low to high',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  horizontalTitleGap: 8,
                  leading: SizedBox(
                    width: 24,
                    height: 24,
                    child: Radio<Sort>(
                      fillColor: MaterialStateProperty.all(Colors.black),
                      value: Sort.priceLowToHigh,
                      groupValue: _sort,
                      onChanged: (Sort? value) {
                        setState(() {
                          _sort = value;
                          widget.onSort(value!);
                        });
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Price, high to low',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  horizontalTitleGap: 8,
                  leading: SizedBox(
                    width: 24,
                    height: 24,
                    child: Radio<Sort>(
                      fillColor: MaterialStateProperty.all(Colors.black),
                      value: Sort.priceHighToLow,
                      groupValue: _sort,
                      onChanged: (Sort? value) {
                        setState(() {
                          _sort = value;
                          widget.onSort(value!);
                        });
                      },
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}

class FilterItem extends StatefulWidget {
  const FilterItem(
      {Key? key,
      required this.subCategory,
      required this.selectedFilters,
      required this.onFilter})
      : super(key: key);
  final SubCategory subCategory;
  final List<String> selectedFilters;
  final Function(String subCatId) onFilter;

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected =
        widget.selectedFilters.contains(widget.subCategory.subCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        horizontalTitleGap: 8,
        title: Text(
          widget.subCategory.name,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        leading: SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: isSelected,
            splashRadius: 0,
            side: BorderSide(color: Colors.grey.shade300, width: 1),
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.all(Colors.black),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            onChanged: (value) {
              setState(() {
                isSelected = !isSelected;
                widget.onFilter(widget.subCategory.subCategoryId);
              });
            },
          ),
        ),
      ),
    );
  }
}
