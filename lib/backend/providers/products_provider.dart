import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/use_cases/product_request/request_product.dart';
import 'package:seller_app/backend/use_cases/products/read_all_products.dart';
import 'package:seller_app/backend/use_cases/products/read_single_product.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  void addProduct(ProductModel product) {
    _products.add(product);
    notifyListeners();
  }

  final ReadAllProductsUseCase _readAllProductsUseCase;
  final ReadAllProductsSortByLikesUseCase _readAllProductsSortByLikesUseCase;
  final ReadAllLatestProductsSortByCreatedUseCase _readAllLatestProductsSortByCreatedUseCase;
  final ReadSingleProductUseCase _readSingleProductUseCase;
  final RequestProductUseCase _requestProductUseCase;
  final CheckProductRequestStatusUseCase _checkProductRequestStatusUseCase;

  Future<List<ProductModel>> getAllProducts() async {
    final result = await _readAllProductsUseCase.getAllProducts();
    _products = result;
    // print(result);
    notifyListeners();
    return result;
  }

  Future<List<ProductModel>> getAllProductsSortByLikes() async => await _readAllProductsSortByLikesUseCase.getAllProductsSortByLikes();

  Future<List<ProductModel>> getAllLatestProductsSortByCreated() async =>
      await _readAllLatestProductsSortByCreatedUseCase.getAllLatestProductsSortByCreated();

  Future<ProductModel> getSingleProduct(String productId) async => await _readSingleProductUseCase.getSingleProduct(productId: productId);

  Future<void> requestProduct({required String productId}) async => await _requestProductUseCase.call(productId: productId);

  Stream<int> checkProductRequestStatus({required productId})  =>  _checkProductRequestStatusUseCase.call(productId: productId);

  void clearProducts() {
    _products = [];
    notifyListeners();
  }

  ProductsProvider({
    required ReadAllProductsUseCase readAllProductsUseCase,
    required ReadAllProductsSortByLikesUseCase readAllProductsSortByLikesUseCase,
    required ReadAllLatestProductsSortByCreatedUseCase readAllLatestProductsSortByCreatedUseCase,
    required ReadSingleProductUseCase readSingleProductUseCase,
    required RequestProductUseCase requestProductUseCase,
    required CheckProductRequestStatusUseCase checkProductRequestStatusUseCase,
  })  : _products = [],
        _readAllProductsUseCase = readAllProductsUseCase,
        _requestProductUseCase = requestProductUseCase,
        _checkProductRequestStatusUseCase = checkProductRequestStatusUseCase,
        _readAllProductsSortByLikesUseCase = readAllProductsSortByLikesUseCase,
        _readAllLatestProductsSortByCreatedUseCase = readAllLatestProductsSortByCreatedUseCase,
        _readSingleProductUseCase = readSingleProductUseCase;
}
