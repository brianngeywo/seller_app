import 'package:seller_app/backend/databases/category_db.dart';
import 'package:seller_app/backend/models/product_model.dart';

class ReadCategoryProductsUseCase {
  final CategoriesDatabase _database;

  ReadCategoryProductsUseCase(this._database);

  Future<List<ProductModel>> getAllSingleCategoryProducts({required String category}) async {
    final result = await _database.getAllSingleCategoryProducts(category: category);
    var products = result.docs.map((e) => ProductModel.fromMap(e.data())).toList();
    return products;
  }
}
