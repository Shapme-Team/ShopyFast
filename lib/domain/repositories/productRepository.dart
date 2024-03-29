import 'package:ShopyFast/data/source/productDataSource.dart';
import 'package:ShopyFast/domain/models/Product.dart';

class ProductRepository {
  final ProductDataSource _productDataSource;
  ProductRepository(this._productDataSource);

  Future<List<Product>> getProductBySubcategory(String sid,
      {int limit = 0}) async {
    var products = await _productDataSource.getProductBySubcategory(sid, limit);
    return products;
  }

  Future<List<Product>> getProductsBySearch(String search) async {
    var products = await _productDataSource.getProductBySearch(search);
    return products;
  }

  Future<Product> getProductById(String id) async {
    var product = await _productDataSource.getProductById(id);
    return product;
  }
}
