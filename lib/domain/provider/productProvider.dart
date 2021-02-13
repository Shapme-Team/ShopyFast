import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/domain/repositories/productRepository.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repository;

  Map<String, List<Product>> _mapOfSubcategory = {};

  ProductProvider(this._repository);

  List<Product> getProductsOfSub(String sid) {
    if (_mapOfSubcategory[sid] != null) {
      return _mapOfSubcategory[sid];
    } else
      return [];
  }

  fetchProductsOfSid(String sid) async {
    if (_mapOfSubcategory[sid] == null) {
      print('new fetch of: $sid');
      var products = await _repository.getProductBySubcategory(sid);
      if (products.length > 0) _mapOfSubcategory[sid] = products;
      notifyListeners();
    } else
      print('products available of sid : $sid ');
  }

  updateProductQuantity(Product product) {
    _mapOfSubcategory[product.subcategory]
        .firstWhere(
          (element) => element.productId == product.productId,
          orElse: () => null,
        )
        ?.quantity = product.quantity;
    notifyListeners();
  }
}
