import 'package:seller_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LikeDisLikeDatabase {
  // Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getSingleProductLikeCount(String productId) async {
  //   // get the count of likes and dislikes for a single product
  //   final likesDocs = await likeDislikesCollection.where("productId", isEqualTo: productId).where("liked", isEqualTo: true).get();
  //   return likesDocs.docs;
  // }
  //
  // Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getSingleProductDislikeCount(String productId) async {
  //   // get the count of likes and dislikes for a single product
  //   final dislikesDocs = await likeDislikesCollection.where("productId", isEqualTo: productId).where("liked", isEqualTo: false).get();
  //   return dislikesDocs.docs;
  // }

  dislikeProduct({required String productId}) async {
    //check if there is anothe document with same productId and firebaseAuth.currentUser!.uid
    // await likeDislikesCollection.where("productId", isEqualTo: productId).where("firebaseAuth.currentUser!.uid", isEqualTo: firebaseAuth
    // .currentUser!.uid)
    // .get()
    // .then(
    // (value) {
    //   if (value.docs.isEmpty) {
        // dislike a product
        likeDislikesCollection.doc("${firebaseAuth.currentUser!.uid}$productId").set({
          "id":"${firebaseAuth.currentUser!.uid}$productId",
          "productId": productId,
          "userId": firebaseAuth.currentUser!.uid,
          "liked": false,
        });
    //   } else {
    //     // remove the dislike
    //     likeDislikesCollection.doc(value.docs.first.id).delete();
    //   }
    // });
  }

  Future<String> likeProduct({required String productId}) async {
    //check if there is anothe document with same productId and firebaseAuth.currentUser!.uid
    // await likeDislikesCollection.where("productId", isEqualTo: productId).where("firebaseAuth.currentUser!.uid", isEqualTo: firebaseAuth
    // .currentUser!.uid)
    // .get()
    // .then(
    // (value) {
    //   if (value.docs.isEmpty) {
        // like a product
    await  likeDislikesCollection.doc("${firebaseAuth.currentUser!.uid}$productId").set({
          "id":"${firebaseAuth.currentUser!.uid}$productId",
          "productId": productId,
          "userId": firebaseAuth.currentUser!.uid,
          "liked": true,
        });
    return "$firebaseAuth.currentUser!.uid$productId";
      // } else {
      //   // remove the like
      //   likeDislikesCollection.doc(value.docs.first.id).delete();
      // }
    // });
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> readProductLikes({required String productId}) async {
    // get the count of likes for a single product
    final likesDocs = await likeDislikesCollection.where("productId", isEqualTo: productId).where("liked", isEqualTo: true).get();
    return likesDocs.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> readProductDislikes({required String productId}) async {
    // get the count of dislikes for a single product
    final dislikesDocs = await likeDislikesCollection.where("productId", isEqualTo: productId).where("liked", isEqualTo: false).get();
    return dislikesDocs.docs;
  }
}
