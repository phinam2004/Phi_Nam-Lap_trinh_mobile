import 'package:app_phi_nam/model/product.dart';
import 'package:dio/dio.dart';

// Replace this with your Postman mock URL or backend URL.
// Example Postman mock base URL: https://<your-mock-id>.mock.pstmn.io
const String API_BASE_URL = 'https://dummyjson.com';

final Dio dio = Dio(BaseOptions(baseUrl: API_BASE_URL));

class Api {
  Future<List<Product>> getAllProducts() async {
    final url = '/products';
    try {
      var response = await dio.get(url);

      List<Product> listProduct = [];

      if (response.statusCode == 200) {
        List data = response.data;
        listProduct = data.map((json) => Product.fromJson(json)).toList();

        print(
          "Lấy dữ liệu thành công, số lượng sản phẩm: ${listProduct.length}",
        );
        if (listProduct.isNotEmpty) print(listProduct[0].title);

        return listProduct;
      } else {
        print('Lỗi khi lấy dữ liệu: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception khi lấy dữ liệu: $e');
      return [];
    }
  }
}
