import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:task/models/product.dart';

class CustomProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ProductModel> products = [];
  List<String> categories = [];
  int num = 8;
  String category = "All Products";

  CustomProvider() {
    fetchData();
    fetchCategories();
  }

  Future<void> fetchData() async {
    // isLoading = true;
    // notifyListeners();
    http.Response response;
    try {
      if (category == 'All Products') {
        response = await http
            .get(Uri.tryParse('https://fakestoreapi.com/products?limit=$num')!);
      } else {
        response = await http.get(Uri.tryParse(
            'https://fakestoreapi.com/products/category/$category')!);
      }
      if (response.statusCode == 200) {
        //var result = jsonDecode(response.body);
        products = productModelFromJson(response.body);
      }
      // isLoading = false;
      // notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // isLoading = false;
      // notifyListeners();
    }
  }

  Future<void> fetchCategories() async {
    isLoading = true;
    notifyListeners();
    try {
      http.Response response = await http
          .get(Uri.tryParse('https://fakestoreapi.com/products/categories')!);
      if (response.statusCode == 200) {
        categories = List<String>.from(jsonDecode(response.body));
        categories.insert(0, "All Products");
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      isLoading = false;
      notifyListeners();
    }
  }
}
