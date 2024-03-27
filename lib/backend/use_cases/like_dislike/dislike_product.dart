import 'package:seller_app/backend/databases/like_dislike_db.dart';

class DislikeProductUseCase {

  final LikeDisLikeDatabase _database;

  DislikeProductUseCase(this._database);

  Future<void> call({required String productId}) async {
    await _database.dislikeProduct(productId: productId, );
  }
}