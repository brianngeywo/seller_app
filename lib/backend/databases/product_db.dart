import 'package:seller_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Stream<int> checkProductRequestStatus({required String productId})  {
    final result =  productRequestsCollection
        .where("productId", isEqualTo: productId)
        .where("userId", isEqualTo: firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
    return result;
  }
}
