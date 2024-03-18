import 'package:seller_app/backend/databases/product_db.dart';

class RequestProductUseCase {
  final ProductsDatabase _productsDatabase;

  RequestProductUseCase({required ProductsDatabase productsDatabase}) : _productsDatabase = productsDatabase;

  Future<void> call({required String productId}) => _productsDatabase.sendProductrequest(productId: productId, );
}

class CheckProductRequestStatusUseCase {
  final ProductsDatabase _productsDatabase;

  CheckProductRequestStatusUseCase({required ProductsDatabase productsDatabase}) : _productsDatabase = productsDatabase;

   Stream<int> call({required String productId}) =>  _productsDatabase.checkProductRequestStatus(productId: productId);

}
