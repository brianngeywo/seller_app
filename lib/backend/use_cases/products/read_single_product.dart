import 'package:seller_app/backend/databases/product_db.dart';
import 'package:seller_app/backend/models/product_model.dart';

class ReadSingleProductUseCase {
  final ProductsDatabase _database;

  ReadSingleProductUseCase(this._database);

  Future<ProductModel> getSingleProduct({required String productId}) async {
    final result = await _database.getSingleProduct(productId: productId);
    var product = ProductModel.fromMap(result.data()!);
    return product;
  }
}