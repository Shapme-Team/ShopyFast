import 'dart:convert';

import 'package:ShopyFast/data/core/apiClient.dart';
import 'package:ShopyFast/data/source/productDataSource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

/*      'grocery#aata#sid': 'Atta',
        'grocery#dryfruits#sid': 'Dry Fruits',
        'grocery#ghee_vanaspati#sid': 'Ghee & Vanaspati',
        'grocery#edible_oils#sid': 'Edible Oils',
*/

main() {
  test(
    " get product by subcategory ",
    () async {
//arrange
      var apiClient = ApiClient(Client());
      var dataSource = ProductDataSourceImpl(apiClient);
      final products =
          await dataSource.getProductBySubcategory('biscute_snack#biscute#sid');
//assert
      final productLength = products?.length;
//test
      expect(true, productLength > 0);
    },
  );
}
