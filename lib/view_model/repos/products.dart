import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jyothi_labs/model/products.dart';

class AllProducts {
  final String url = 'https://dummyjson.com/products/categories';
  Future<List<AllProductsModel>> fetchAllProdocts() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        print('all categories are fetched');
        return data.map((value) => AllProductsModel.formjson(value)).toList();
      } else {
        print('Data all products didn\'nt get from server');
        return [];
      }
    } catch (e) {
      print('all categories could\'nt get $e');
      return [];
    }
  }
}
