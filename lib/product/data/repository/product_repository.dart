import 'package:bloc_api/product/data/model/product_model.dart';

import '../../../data/data_provider.dart';

class ProductRepository {
  DataProvider dataProvider = DataProvider();
  Future<List<Product>> getProducts() async {
    try {
      final response = await DataProvider.getRequest(
          endpoint: "https://dummyjson.com/products");
      if (response.statusCode == 200) {
        List<Product> products =
            ProductModel.fromRawJson(response.body).products;
        return products;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }
}
