import 'package:seller_app/backend/databases/product_db.dart';
import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/models/product_request_model.dart';

class CreateSingleProductUseCase {
  final ProductsDatabase _database;

  CreateSingleProductUseCase(this._database);

  Future<void> call({required ProductModel product}) async => await _database.createSingleProduct(product: product);
}

class ReadSingleProductUseCase {
  final ProductsDatabase _database;

  ReadSingleProductUseCase(this._database);

  Future<ProductModel> call({required String productId}) async {
    final result = await _database.getSingleProduct(productId: productId);
    var product = ProductModel.fromMap(result.data()!);
    return product;
  }
}

class EditSingleProductUseCase {
  final ProductsDatabase _database;

  EditSingleProductUseCase(this._database);

  Future<void> call({required ProductModel product}) async => await _database.editSingleProduct(product: product);
}

class DeleteSingleProductUseCase {
  final ProductsDatabase _database;

  DeleteSingleProductUseCase(this._database);

  Future<void> call({required String productId}) async => await _database.deleteSingleProduct(productId: productId);
}

class GetAllProductRequestsUsingVendorIdUseCase {
  final ProductsDatabase _database;

  GetAllProductRequestsUsingVendorIdUseCase(this._database);

  Future<List<ProductRequestModel>> call({required String vendorId}) async {
    final request = await _database.getAllProductRequestsUsingVendorIdUseCase(vendorId: vendorId);
    final result = request.docs.map((e) => ProductRequestModel.fromMap(e.data())).toList();
    return result;
  }
}

class GetAllClientsUsingVendorIdUseCase {
  final ProductsDatabase _database;
  List<String> numberOfUsers = [];


  GetAllClientsUsingVendorIdUseCase(this._database);

  Future<List<String>> call({required String vendorId}) async {
    final request = await _database.getAllProductRequestsUsingVendorIdUseCase(vendorId: vendorId);
    final result = request.docs.map((e) => ProductRequestModel.fromMap(e.data())).toList();
    for (ProductRequestModel productRequest in result) {
      final userId = productRequest.requesterId;
      numberOfUsers.add(userId);
    }
    return numberOfUsers;
  }
}
