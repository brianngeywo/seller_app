import 'package:seller_app/backend/databases/product_db.dart';
import 'package:seller_app/backend/models/product_request_model.dart';

class GetAllRequestsUseCase {
  final ProductsDatabase _productsDatabase;

  GetAllRequestsUseCase( ProductsDatabase productsDatabase) : _productsDatabase = productsDatabase;

  Future<List<ProductRequestModel>> call({required String productId}) async => await
      _productsDatabase.getAllProductRequests(productId: productId);
}
