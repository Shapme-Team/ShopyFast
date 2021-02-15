import 'package:ShopyFast/data/core/apiClient.dart';
import 'package:ShopyFast/data/source/productDataSource.dart';
import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/domain/repositories/productRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getIt = GetIt.I;

Future init() async {
  getIt.registerSingleton<Client>(Client());
  getIt.registerSingleton<ProductDataSource>(
      ProductDataSourceImpl(ApiClient(getIt())));
  // getIt.register(() => null)

  getIt.registerSingleton<ProductRepository>(ProductRepository(getIt()));
  getIt.registerSingleton<ProductProvider>(ProductProvider(getIt()));
  getIt.registerSingleton<CartProvider>(CartProvider());
}
