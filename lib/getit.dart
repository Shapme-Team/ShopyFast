import 'package:ShopyFast/data/core/apiClient.dart';
import 'package:ShopyFast/data/source/productDataSource.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/domain/repositories/productRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getIt = GetIt.I;

Future init() async {
  final appDocumentDir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  getIt.registerSingleton<Client>(Client());
  getIt.registerSingleton<ProductDataSource>(
      ProductDataSourceImpl(ApiClient(getIt())));

  getIt.registerSingleton<ProductRepository>(ProductRepository(getIt()));
  getIt.registerSingleton<ProductProvider>(ProductProvider(getIt()));
}
