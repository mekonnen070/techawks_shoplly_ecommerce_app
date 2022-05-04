// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:techawks_shoplly_ecommerce_app/model/category.dart';
import 'package:techawks_shoplly_ecommerce_app/model/product.dart';
import 'package:techawks_shoplly_ecommerce_app/model/sub_category.dart';
import 'package:techawks_shoplly_ecommerce_app/provider/CartProvider.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/cart/ContinueShoppingHome.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/home/components/category_list.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/home/components/itemCard.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/home/filter_sort_screen.dart';
import 'package:techawks_shoplly_ecommerce_app/services/category.dart';
import 'package:techawks_shoplly_ecommerce_app/services/product.dart';
import 'package:techawks_shoplly_ecommerce_app/widgets/CustomOutlinedButton.dart';
import 'package:techawks_shoplly_ecommerce_app/widgets/cart_item_length.dart';

class ProductTabHomePage extends StatefulWidget {
  const ProductTabHomePage({Key? key}) : super(key: key);

  @override
  State<ProductTabHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProductTabHomePage> {
  String selectedCategoryId = "aeb50ed6-580d-a065-383a-e3932fbec6a1";
  List<SubCategory> subCategoryies = [];
  List<Product> products = [];
  List<Product> filteredProducts = [];
  List<String> selectedFilters = [];
  bool loading = false;
  Sort? selectedSort;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late ScrollController _scrollController;

  void onChangeCategory(String catId, List<SubCategory> subCats) async {
    setState(() {
      loading = true;
      selectedCategoryId = catId;
      subCategoryies = subCats;
    });
    getProducts(catId);
  }

  void getCategories() async {
    List<Category>? _category = await CategoryService.categories();

    setState(() {
      selectedCategoryId = _category![0].categoryId;
      subCategoryies = _category[0].subCategories;
    });
  }

  void getProducts(String catId) async {
    List<Product>? prods = await ProductService.products(catId);
    if (prods != null) {
      setState(() {
        products = prods;
        filteredProducts = prods;
        loading = false;
      });
    }

    if (selectedSort != null) {
      onSort(selectedSort!);
    }
  }

  List<Product> getFilteredProducts(List<String> fils) {
    List<Product> filProducts = [];
    if (fils.isNotEmpty) {
      for (var fil in fils) {
        for (var prod in products) {
          if (fil == prod.subCategoryId) {
            filProducts = [...filProducts, prod];
          }
        }
      }
    } else {
      filProducts = products;
    }

    return filProducts;
  }

  void onFilter(String subCatId) {
    List<String> fils;
    if (selectedFilters.contains(subCatId)) {
      fils = selectedFilters.where((el) => el != subCatId).toList();
    } else {
      fils = [...selectedFilters, subCatId];
    }

    setState(() {
      selectedFilters = fils;
      filteredProducts = getFilteredProducts(fils);
    });

    if (selectedSort != null) {
      onSort(selectedSort!);
    }
  }

  void onSearch(String value) {
    if (value != "") {
      List<Product> searchProducts = products
          .where(
              (prod) => prod.name.toLowerCase().contains(value.toLowerCase()))
          .toList();

      setState(() {
        filteredProducts = searchProducts;
      });
    } else {
      setState(() {
        filteredProducts = products;
      });
    }
  }

  void onSort(Sort sort) {
    if (sort == Sort.discounts) {
      setState(() {
        filteredProducts.sort((a, b) => b.discount.compareTo(a.discount));
      });
    } else if (sort == Sort.bestSelling) {
      setState(() {
        filteredProducts.sort((a, b) => b.name.compareTo(a.name));
      });
    } else if (sort == Sort.priceLowToHigh) {
      setState(() {
        filteredProducts.sort((a, b) => a.price.compareTo(b.price));
      });
    } else if (sort == Sort.priceHighToLow) {
      setState(() {
        filteredProducts.sort((a, b) => b.price.compareTo(a.price));
      });
    }
    setState(() {
      selectedSort = sort;
    });
  }

  void onClear() {
    setState(() {
      filteredProducts = products;
      selectedFilters = [];
      selectedSort = null;
    });

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    getCategories();
    getProducts(selectedCategoryId);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomTabHome = <Widget>[
      const Center(
        child: Text(
          'Home',
          style: optionStyle,
        ),
      ),
      ProductBody(
        selectedCategoryId: selectedCategoryId,
        subCategories: subCategoryies,
        onSort: onSort,
        onClear: onClear,
        onFilter: onFilter,
        onSearch: onSearch,
        selectedFilters: selectedFilters,
        selectedSort: selectedSort,
        onChangeCategory: onChangeCategory,
        loading: loading,
        product: products,
      ),
      const Center(
        child: Text(
          'Contact',
          style: optionStyle,
        ),
      ),
      const Center(
        child: Text(
          ' About',
          style: optionStyle,
        ),
      ),
    ];

    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: SvgPicture.asset(
            'assets/Icons/logo.svg',
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (cartProvider.items.isNotEmpty) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const CartHome()));
                      }
                    },
                    child: SizedBox(
                      width: 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1)),
                            child: SvgPicture.asset(
                              "assets/Icons/bag.svg",
                            ),
                          ),
                          const Positioned(
                            left: 30,
                            top: -5,
                            child: CartItemLength(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/random_profile.jpg'),
                  )
                ],
              ),
            ),
          ],
        ),
        body: bottomTabHome.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: 'Product',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Contact',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class ProductBody extends StatefulWidget {
  final Function(String catId, List<SubCategory> subCats) onChangeCategory;
  final Function(Sort sort) onSort;
  final Function(String subCatId) onFilter;
  final Function(String value) onSearch;
  final Function() onClear;
  final String selectedCategoryId;
  final List<String> selectedFilters;
  final List<SubCategory> subCategories;
  final Sort? selectedSort;
  List<Product> product;
  final bool loading;

  ProductBody({
    Key? key,
    required this.onChangeCategory,
    required this.onSort,
    required this.onFilter,
    required this.onSearch,
    required this.onClear,
    required this.selectedCategoryId,
    required this.selectedFilters,
    required this.subCategories,
    this.selectedSort,
    required this.product,
    required this.loading,
  }) : super(key: key);

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  bool isFetched = false;

  List<Product> fdp = [];

  dynamic result;

  void onSearch(String value) {
    fdp = widget.product;
    if (value != "") {
      List<Product> searchProducts = widget.product
          .where(
              (prod) => prod.name.toLowerCase().contains(value.toLowerCase()))
          .toList();

      setState(() {
        widget.product = searchProducts;
      });
    } else {
      setState(() {
        widget.product = fdp;
      });
    }
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border:
                          Border.all(color: Colors.grey.shade200, width: 1)),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/Icons/search.svg"),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: controller,
                          onChanged: (value) {
                            onSearch(value);
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18.0,
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return FilterSortScreen(
                      selectedSort: widget.selectedSort,
                      subCategories: widget.subCategories,
                      onClear: widget.onClear,
                      selectedFilters: widget.selectedFilters,
                      onSort: widget.onSort,
                      onFilter: widget.onFilter,
                    );
                  }),
                ),
                child: Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.grey.shade200, width: 1)),
                    child: SvgPicture.asset(
                      "assets/Icons/filter.svg",
                      color: Colors.black,
                      width: 20,
                      height: 20,
                    )),
              )
            ],
          ),
          SizedBox(
            height: 40,
            child: CategoryList(
              onChangeCategory: widget.onChangeCategory,
              selectedCategoryId: widget.selectedCategoryId,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.product.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ItemCard(
                    loading: widget.loading,
                    product: widget.product[index],
                    products: widget.product,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
