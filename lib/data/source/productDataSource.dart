import 'package:ShopyFast/data/core/apiClient.dart';
import 'package:ShopyFast/domain/models/Product.dart';

abstract class ProductDataSource {
  Future<List<Product>> getProductBySubcategory(String sid);
  Future<Product> getProductById(String id);
}

class ProductDataSourceImpl extends ProductDataSource {
  final ApiClient _apiClient;
  ProductDataSourceImpl(this._apiClient);

  @override
  Future<Product> getProductById(String id) async {
    try {} catch (err) {}
  }

  @override
  Future<List<Product>> getProductBySubcategory(String sid) async {
    sid = sid.replaceAll('#', '%23');
    try {
      var response = await _apiClient.get('product/subcategory/$sid') as List;
      return response.map((e) => Product.fromMap(e)).toList();
    } catch (err) {
      print('error while sub fetch : $err');
      return [];
    }
  }
}
