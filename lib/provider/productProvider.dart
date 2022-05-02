import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:techawks_shoplly_ecommerce_app/model/products.dart';

class ProductProvider extends ChangeNotifier {
  late Product product;
}
