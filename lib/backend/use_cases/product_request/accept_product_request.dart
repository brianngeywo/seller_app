import 'package:seller_app/backend/databases/product_db.dart';

class AcceptRequestProductUseCase {
  final ProductsDatabase _productsDatabase;

  AcceptRequestProductUseCase(ProductsDatabase productsDatabase) : _productsDatabase = productsDatabase;

  Future<void> call({required String requestId}) => _productsDatabase.acceptedRequest(
        requestId: requestId,
      );
}

class DenyRequestProductUseCase {
  final ProductsDatabase _productsDatabase;

  DenyRequestProductUseCase(ProductsDatabase productsDatabase) : _productsDatabase = productsDatabase;

  Future<void> call({required String requestId}) => _productsDatabase.denyRequest(
        requestId: requestId,
      );
}

class DeleteProductRequestUseCase {
  final ProductsDatabase _productsDatabase;

  DeleteProductRequestUseCase(ProductsDatabase productsDatabase) : _productsDatabase = productsDatabase;

  Future<void> call({required String requestId}) => _productsDatabase.deleteRequest(requestId: requestId);
}
