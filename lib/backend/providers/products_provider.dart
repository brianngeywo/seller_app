import 'package:flutter/material.dart';
import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/models/product_request_model.dart';
import 'package:seller_app/backend/use_cases/product_request/accept_product_request.dart';
import 'package:seller_app/backend/use_cases/product_request/get_all_product_requests.dart';
import 'package:seller_app/backend/use_cases/product_request/request_product.dart';
import 'package:seller_app/backend/use_cases/products/read_all_products.dart';
import 'package:seller_app/backend/use_cases/products/read_single_product.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> products = [];
  List<ProductRequestModel> productRequests = [];

  final ReadAllProductsUseCase readAllProductsUseCase;
  final ReadAllProductsSortByLikesUseCase readAllProductsSortByLikesUseCase;
  final ReadAllLatestProductsSortByCreatedUseCase readAllLatestProductsSortByCreatedUseCase;
  final ReadSingleProductUseCase readSingleProductUseCase;
  final RequestProductUseCase requestProductUseCase;
  final CheckProductRequestStatusUseCase checkProductRequestStatusUseCase;
  final GetAllRequestsUseCase getAllRequestsUseCase;
  final AcceptRequestProductUseCase acceptRequestProductUseCase;
  final DenyRequestProductUseCase denyRequestProductUseCase;
  final DeleteProductRequestUseCase deleteProductRequestUseCase;
  final DeleteSingleProductUseCase deleteSingleProductUseCase;
  final EditSingleProductUseCase editSingleProductUseCase;
  final GetAllProductRequestsUsingVendorIdUseCase getAllProductRequestsUsingVendorIdUseCase;

  Future<List<ProductModel>> getAllProducts() async {
    final result = await readAllProductsUseCase.call();
    products = result;
    // print(result);
    notifyListeners();
    return result;
  }

  Future<List<ProductModel>> getAllProductsSortByLikes() async =>
      await readAllProductsSortByLikesUseCase.getAllProductsSortByLikes();

  Future<List<ProductModel>> getAllLatestProductsSortByCreated() async =>
      await readAllLatestProductsSortByCreatedUseCase.getAllLatestProductsSortByCreated();

  Future<List<ProductRequestModel>> getAllProductRequests({required String productId}) async {
    final result = await getAllRequestsUseCase.call(productId: productId);
    productRequests = result;
    notifyListeners();
    return result;
  }

  Future<ProductModel> getSingleProduct(String productId) async =>
      await readSingleProductUseCase.getSingleProduct(productId: productId);

  Future<void> deleteSingleProduct(String productId) async =>
      await deleteSingleProductUseCase.deleteSingleProduct(productId: productId);

  Future<void> editProduct({required ProductModel product}) async =>
      await editSingleProductUseCase.editSingleProduct(product: product);

  Future<void> requestProduct({required String productId}) async =>
      await requestProductUseCase.call(productId: productId);

  Stream<int> checkProductRequestStatus({required productId}) =>
      checkProductRequestStatusUseCase.call(productId: productId);

  void clearProducts() {
    products = [];
    notifyListeners();
  }

  ProductsProvider({
    required this.readAllProductsUseCase,
    required this.readAllProductsSortByLikesUseCase,
    required this.readAllLatestProductsSortByCreatedUseCase,
    required this.readSingleProductUseCase,
    required this.requestProductUseCase,
    required this.checkProductRequestStatusUseCase,
    required this.getAllRequestsUseCase,
    required this.acceptRequestProductUseCase,
    required this.denyRequestProductUseCase,
    required this.deleteProductRequestUseCase,
    required this.deleteSingleProductUseCase,
    required this.editSingleProductUseCase,
    required this.getAllProductRequestsUsingVendorIdUseCase,
  });

  Future<List<ProductRequestModel>> getAllProductRequestsUsingVendorId({required String vendorId}) async =>
      await getAllProductRequestsUsingVendorIdUseCase.getAllProductRequestsUsingVendorIdUseCase(vendorId: vendorId);
}
