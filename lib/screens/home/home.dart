// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:techawks_shoplly_ecommerce_app/Schemas/get_task_schema.dart';
import 'package:techawks_shoplly_ecommerce_app/constants/constants.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/cart/ContinueShoppingHome.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/home/components/categoryList.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/home/components/icon_btn_with_counter.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/home/components/itemCard.dart';
import 'package:techawks_shoplly_ecommerce_app/screens/home/components/search_field.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[
    const Center(
      child: Text(
        ' Home',
        style: optionStyle,
      ),
    ),
    ProductBody(),
    const Center(
      child: Text(
        'Profile',
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  IconBtnWithCounter(
                    svgSrc: "assets/Icons/bag.svg",
                    numOfitem: 5,
                    press: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => const CartHome()));
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/random_profile.jpg'),
                  )
                ],
              ),
            ),
          ],
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
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
              icon: Icon(Icons.shopping_cart),
              label: 'Profile',
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

class ProductBody extends StatelessWidget {
  ProductBody({
    Key? key,
  }) : super(key: key);
  bool isFetched = false;

  dynamic result;

  @override
  Widget build(BuildContext context) {
    return Query(
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
          return const Text('No categories');
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SearchField(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ClipOval(
                    child: Container(
                      color: Colors.grey,
                      padding: const EdgeInsets.all(1),
                      child: const CircleAvatar(
                        backgroundColor: bgColor,
                        child: Icon(Icons.menu_outlined),
                      ),
                    ),
                  ),
                ],
              ),
              CategoriesList(
                categories: result.data?['categories'],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final product =
                        result.data?['categories'][index]['products'][index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ItemCard(
                        product: product,
                        index: index,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
