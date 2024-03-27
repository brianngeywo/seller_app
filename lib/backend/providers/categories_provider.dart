import 'package:flutter/material.dart';
import 'package:seller_app/backend/models/category_model.dart';
import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/use_cases/categories/read_all_categories.dart';
import 'package:seller_app/backend/use_cases/categories/read_category_products.dart';

class CategoriesProvider extends ChangeNotifier {
  CategoriesProvider({
    required ReadAllcategoriesUseCase allcategoriesUseCase,
    required ReadCategoryProductsUseCase categoryProductsUseCase,
  })  : _categories = [],
        _allcategoriesUseCase = allcategoriesUseCase,
        _categoryProductsUseCase = categoryProductsUseCase;
  List<CategoryModel> _categories = [];
  CategoryModel? _selectedCategory;

  CategoryModel get selectedCategory => _selectedCategory!;

  set selectedCategory(CategoryModel value) {
    _selectedCategory = value;
    notifyListeners();
  }

  List<CategoryModel> get categories => _categories;
  final ReadAllcategoriesUseCase _allcategoriesUseCase;
  final ReadCategoryProductsUseCase _categoryProductsUseCase;

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await _allcategoriesUseCase.call();
    _categories = response;
    notifyListeners();
    return response;
  }

  selectCategory(CategoryModel category) async {
    await fetchCategoryProducts(category.id);
    _selectedCategory = category;
    notifyListeners();
  }

  Future<List<ProductModel>> fetchCategoryProducts(String categoryId) async =>
      await _categoryProductsUseCase.call(category: categoryId);
}
