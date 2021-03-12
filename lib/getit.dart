import 'package:ShopyFast/domain/provider/orderProvider.dart';
import 'package:ShopyFast/domain/provider/screenRouteProvider.dart';
import 'package:ShopyFast/domain/repositories/customerRepository.dart';
import 'package:ShopyFast/domain/repositories/orderRepository.dart';

import 'data/source/customerDataSource.dart';
import 'package:firebase_core/firebase_core.dart';

import 'data/core/apiClient.dart';
import 'data/source/hiveLocalDatabase.dart';
import 'data/source/orderDataSource.dart';
import 'data/source/productDataSource.dart';
import 'domain/provider/authprovider.dart';
import 'domain/provider/cartProvider.dart';
import 'domain/provider/productProvider.dart';
import 'domain/repositories/cartRepository.dart';
import 'domain/repositories/productRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getIt = GetIt.I;

Future init() async {
  getIt.registerSingletonAsync<FirebaseApp>(() => Firebase.initializeApp());

  getIt.registerSingletonAsync<HiveLocalDatabase>(
      () => HiveLocalDatabaseImpl.createDatabase());
  getIt.registerSingleton<Client>(Client());
  getIt.registerSingleton<ApiClient>(ApiClient(getIt()));

//----------- data source
  getIt.registerSingleton<ProductDataSource>(ProductDataSourceImpl(getIt()));
  getIt.registerSingleton<OrderDataSource>(OrderDataSourceApiImple(getIt()));
  getIt.registerSingleton<CustomerDataSource>(
      CustomerDataSourceApiImple(getIt()));

//----------- repository
  getIt.registerSingleton<ProductRepository>(ProductRepository(getIt()));
  getIt.registerSingletonWithDependencies<CartReposotory>(
      () => CartReposotoryImp(getIt()),
      dependsOn: [HiveLocalDatabase]);
  getIt.registerSingletonWithDependencies<CustomerRepository>(
      () => CustomerRespositoryImp(getIt(), getIt()),
      dependsOn: [HiveLocalDatabase]);
  getIt.registerSingleton<OrderRepository>(OrderRepositoryImple(getIt()));

//----------- provider
  getIt.registerSingleton<ProductProvider>(ProductProvider(getIt()));
  getIt.registerSingletonWithDependencies<CartProvider>(
      () => CartProvider(getIt()),
      dependsOn: [CartReposotory]);
  getIt.registerSingletonWithDependencies<AuthProvider>(
      () => (AuthProvider(getIt())),
      dependsOn: [FirebaseApp, CustomerRepository]);
  getIt.registerSingleton<ScreenRouteProvider>(ScreenRouteProvider());
  getIt.registerSingleton<OrderProvider>(OrderProvider(getIt()));
}
