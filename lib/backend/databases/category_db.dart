import 'package:seller_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesDatabase {
  Future<QuerySnapshot<Map<String, dynamic>>> getAllcategories()async => await categoriesCollection.get();
  Future<QuerySnapshot<Map<String, dynamic>>> getAllSingleCategoryProducts({required String category})async => await productsCollection.where("categoryId", isEqualTo: category).get();
}