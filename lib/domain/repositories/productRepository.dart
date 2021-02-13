import 'package:ShopyFast/data/source/productDataSource.dart';
import 'package:ShopyFast/domain/models/Product.dart';

class ProductRepository {
  final ProductDataSource _productDataSource;
  ProductRepository(this._productDataSource);

  Future<List<Product>> getProductBySubcategory(String sid) async {
    var products = await _productDataSource.getProductBySubcategory(sid);
    return products;
  }
}
