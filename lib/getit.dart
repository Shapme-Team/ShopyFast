import 'package:ShopyFast/data/core/apiClient.dart';
import 'package:ShopyFast/data/source/hiveLocalDatabase.dart';
import 'package:ShopyFast/data/source/productDataSource.dart';
import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/domain/provider/google_signin.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/domain/repositories/cartRepository.dart';
import 'package:ShopyFast/domain/repositories/productRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getIt = GetIt.I;

Future init() async {
  getIt.registerSingleton<GoogleSignInProvider>(GoogleSignInProvider());

  getIt.registerSingletonAsync<HiveLocalDatabase>(
      () => HiveLocalDatabaseImpl.createDatabase());

  getIt.registerSingletonWithDependencies<CartReposotory>(
      () => CartReposotoryImp(getIt()),
      dependsOn: [HiveLocalDatabase]);
  getIt.registerSingletonWithDependencies<CartProvider>(
      () => CartProvider(getIt()),
      dependsOn: [CartReposotory]);

  getIt.registerSingleton<Client>(Client());
  getIt.registerSingleton<ProductDataSource>(
      ProductDataSourceImpl(ApiClient(getIt())));

  getIt.registerSingleton<ProductRepository>(ProductRepository(getIt()));
  getIt.registerSingleton<ProductProvider>(ProductProvider(getIt()));
}
