import 'package:ShopyFast/data/core/apiClient.dart';
import 'package:ShopyFast/domain/models/Product.dart';

abstract class ProductDataSource {
  Future<List<Product>> getProductBySubcategory(String sid);
  Future<List<Product>> getProductBySearch(String search);
  Future<Product> getProductById(String id);
  // Future<Product> getProductById(String id);
}

class ProductDataSourceImpl extends ProductDataSource {
  final ApiClient _apiClient;
  ProductDataSourceImpl(this._apiClient);

  // @override
  // Future<Product> getProductById(String id) async {
  //   try {} catch (err) {}
  // }

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

  @override
  Future<List<Product>> getProductBySearch(String search) async {
    try {
      var response = await _apiClient.get('product/search/$search') as List;
      return response.map((e) => Product.fromMap(e)).toList();
    } catch (err) {
      print('error while sub fetch : $err');
      return [];
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      var response = await _apiClient.get('product/$id');
      // print('response : ${Product.fromMap(response).toString()}');

      return Product.fromMap(response);
    } catch (err) {
      print('error while getting product : $err');
      return null;
    }
  }
}
