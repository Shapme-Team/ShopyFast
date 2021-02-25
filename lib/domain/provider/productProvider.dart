import 'package:ShopyFast/domain/models/Cart.dart';
import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/domain/repositories/productRepository.dart';
import 'package:ShopyFast/utils/categoryConstants.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repository;
  Cart _cartItems;
  List<Product> _searchProducts;
  List<MapEntry<String, String>> _searchAutoComplete = [];
  bool _isLoading = false;

  Map<String, List<Product>> _mapOfSubcategory = {};

  ProductProvider(this._repository);

  bool get getLoadingState => _isLoading;

  List<Product> get getSearchResultProducts => _searchProducts;
  clearSearchProduct() {
    _searchProducts = null;
    print('clear searhc products: $_searchProducts');
  }

  List<MapEntry<String, String>> get getSearchAutoComplete =>
      _searchAutoComplete;

  List<Product> getProductsOfSub(String sid) {
    if (_mapOfSubcategory[sid] != null) {
      return _mapOfSubcategory[sid];
    } else
      return [];
  }

  initCartItems(Cart cart) {
    if (_cartItems == null) {
      _cartItems = cart;
      print('cart items in product provider: $_cartItems');
    }
  }

  fetchProductsOfSid(String sid, [bool isSearch]) async {
    List<Product> products;
    if (_mapOfSubcategory[sid] == null) {
      if (isSearch != null) setLoading(true); // for searching
      products = await _repository.getProductBySubcategory(sid);
      refreshProductsWithCartItems(products); // load cart items
      _mapOfSubcategory[sid] = products;
      if (isSearch != null) setLoading(false); // for searching

    } else {
      refreshProductsWithCartItems(_mapOfSubcategory[sid]);
    }
    if (isSearch != null) {
      _searchProducts = _mapOfSubcategory[sid] ?? [];
      notifyListeners();
    }
  }

  updateProductQuantity(Product product) {
    _mapOfSubcategory[product.subcategory]
        ?.firstWhere((element) => element.productId == product.productId,
            orElse: () => null)
        ?.quantity = product.quantity;
    notifyListeners();
  }

  getProductBySearch(String searchString) async {
    setLoading(true);
    print('provider search string : $searchString');
    var searchProducts = await _repository.getProductsBySearch(searchString);
    refreshProductsWithCartItems(searchProducts);
    _searchProducts = searchProducts;
    print('search item : ${_searchProducts.length}');
    setLoading(false);
  }

  searchAutoComplete(String value) {
    var categories = CategoriesConstant.CATEGORY_CONSTANTS;
    var sub = CategoriesConstant.SUBCATEGORIES;
    List<MapEntry<String, String>> searchResult = [];

    categories.entries.forEach((category) {
      var subcategory = category.value[sub] as Map<String, String>;
      subcategory.entries.forEach((subItem) {
        if (subItem.value.toLowerCase().contains(value.toLowerCase())) {
          searchResult.add(subItem);
        }
      });
    });
    _searchAutoComplete = searchResult;
    print('set length : ${searchResult.length}');
    notifyListeners();
  }

  refreshProductsWithCartItems(List<Product> listOfProducts) {
    listOfProducts.forEach((subProduct) {
      _cartItems.product.forEach((cartProduct) {
        if (cartProduct.productId == subProduct.productId)
          subProduct.quantity = cartProduct.quantity;
        else
          subProduct.quantity = 0;
      });
    });
  }

  setLoading(bool state) {
    _isLoading = state;
    notifyListeners();
  }
}
