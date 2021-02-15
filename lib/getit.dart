import 'package:ShopyFast/data/core/apiClient.dart';
import 'package:ShopyFast/data/source/productDataSource.dart';
import 'package:ShopyFast/domain/models/Product.dart';
import 'package:ShopyFast/domain/models/order.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:ShopyFast/domain/provider/cartProvider.dart';
import 'package:ShopyFast/domain/provider/productProvider.dart';
import 'package:ShopyFast/domain/repositories/productRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getIt = GetIt.I;

Future init() async {
  final appDocumentDir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(OrderAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.openBox(
    'orders',
    // compactionStrategy: (int total, int deleted) {
    //   return deleted > 20;
    // },
  );
  // var box = await Hive.openBox('myBox');
  getIt.registerSingleton<Client>(Client());
  getIt.registerSingleton<ProductDataSource>(
      ProductDataSourceImpl(ApiClient(getIt())));
  // getIt.register(() => null)

  getIt.registerSingleton<ProductRepository>(ProductRepository(getIt()));
  getIt.registerSingleton<ProductProvider>(ProductProvider(getIt()));
  getIt.registerSingleton<CartProvider>(CartProvider());
}
