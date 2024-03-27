
import 'package:seller_app/backend/databases/category_db.dart';
import 'package:seller_app/backend/models/category_model.dart';

class ReadAllcategoriesUseCase {
  final CategoriesDatabase _database;

  ReadAllcategoriesUseCase(this._database);

   Future<List<CategoryModel>> call() async {
    final result =  await _database.getAllcategories();
    var categories = result.docs.map((e) => CategoryModel.fromMap(e.data())).toList();
    return categories;
  }
}