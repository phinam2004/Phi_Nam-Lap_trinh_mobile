import 'package:app_phi_nam/bai8/model/product.dart';
import 'package:dio/dio.dart';

class API {
  Future<List<Product>?> getAllProduct() async {
    String apiUrl = "https://fakestoreapi.com/products";
    var dio = Dio();
    var response = await dio.request(apiUrl, options: Options(method: 'GET'));

    if (response.statusCode == 200) {
      List products = response.data;
      return products.map((json) => Product.fromJson(json)).toList();
    } else {
      print(response.statusMessage);
    }

    return null;
  }
}
