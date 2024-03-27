// This class can inject necessary dependencies like FirebaseFirestore
import 'package:seller_app/constants.dart';

class GetProductLikesCountUseCase {
  // Stream returning the count of likes for a specific product
  Stream<int> call(String productId) {
    return likeDislikesCollection
        .where('productId', isEqualTo: productId)
        .where('liked', isEqualTo: true) // Filter only likes
        .snapshots()
        .map((snapshot) => snapshot.docs.length); // Count documents
  }
}

class GetProductDisLikesCountUseCase {
  Stream<int> call(String productId) {
    return likeDislikesCollection
        .where('productId', isEqualTo: productId)
        .where('liked', isEqualTo: false) // Filter only dislikes
        .snapshots()
        .map((snapshot) => snapshot.docs.length); // Count documents
  }
}
