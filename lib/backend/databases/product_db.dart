import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/models/product_request_model.dart';
import 'package:seller_app/constants.dart';

class ProductsDatabase {
  Future<QuerySnapshot<Map<String, dynamic>>> getAllProducts() async => await productsCollection.get();

  Future<DocumentSnapshot<Map<String, dynamic>>> getSingleProduct({required String productId}) {
    return productsCollection.doc(productId).get();
  }

  getAllProductsSortByLikes() async {}

  getAllLatestProductsSortByCreated() async {}

  Future<void> sendProductrequest({required String productId}) async {
    var user = firebaseAuth.currentUser!;
    await productRequestsCollection.doc("${user.uid}$productId").set({
      'id': "${user.uid}$productId",
      'productId': productId,
      'userId': user.uid,
    });
    // print(id);
  }

  Stream<int> checkProductRequestStatus({required String productId}) {
    final result = productRequestsCollection
        .where("productId", isEqualTo: productId)
        .where("userId", isEqualTo: firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
    return result;
  }

  Future<List<ProductRequestModel>> getAllProductRequests({required String productId}) async {
    final request = await productRequestsCollection.where("productId", isEqualTo: productId).get();
    final result = request.docs.map((e) => ProductRequestModel.fromMap(e.data())).toList();
    return result;
  }

  acceptedRequest({required String requestId}) async {
    // final request = await productRequestsCollection.where("productId", isEqualTo: productId).get();
    await productRequestsCollection.doc(requestId).update({"isAccepted": true});
  }

  denyRequest({required String requestId}) async {
    await productRequestsCollection.doc(requestId).update({"isDenied": true});
  }

  deleteRequest({required String requestId}) async {
    await productRequestsCollection.doc(requestId).delete();
  }

  editSingleProduct({required ProductModel product}) async =>
      await productsCollection.doc(product.id).update(product.toMap());

  deleteSingleProduct({required String productId}) async =>
      await productsCollection.doc(productId).delete();

  createSingleProduct({required ProductModel product}) async {
    await productRequestsCollection.doc(product.id).set(product.toMap());
  }

 Future<QuerySnapshot<Map<String, dynamic>>> getAllProductRequestsUsingVendorIdUseCase({required String vendorId})  async {
    final request = await productRequestsCollection.where("vendorId", isEqualTo: vendorId).get();
    // final result = request.docs.map((e) => ProductRequestModel.fromMap(e.data())).toList();
    return request;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllProductsUsingVendorId({required String vendorId}) async{
    final request = await productsCollection.where("vendorId", isEqualTo: vendorId).get();
    // final result = request.docs.map((e) => ProductModel.fromMap(e.data())).toList();
    return request;
  }
}