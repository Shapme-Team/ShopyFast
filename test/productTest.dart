import 'dart:convert';

import 'package:ShopyFast/data/core/apiClient.dart';
import 'package:ShopyFast/data/source/productDataSource.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/domain/repositories/productRepository.dart';
import 'package:ShopyFast/utils/categoryConstants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

/*      'grocery#aata#sid': 'Atta',
        'grocery#dryfruits#sid': 'Dry Fruits',
        'grocery#ghee_vanaspati#sid': 'Ghee & Vanaspati',
        'grocery#edible_oils#sid': 'Edible Oils',
*/

main() {
  test(
    " get product by subcategory from stream ",
    () async {
//arrange
      bool check = false;
      var apiClient = ApiClient(Client());
      var dataSource = ProductDataSourceImpl(apiClient);
      var productProvider = ProductProvider(ProductRepository(dataSource));
      final productsStream = productProvider
          .getProductSnapStream(CategoriesConstant.SPECIAL_SUBCATEGORIES);
//assert
      productsStream.listen((event) {
        check = event.length > 0;
        print('check : $check');
      });
//test
      expect(true, check);
    },
  );
}
