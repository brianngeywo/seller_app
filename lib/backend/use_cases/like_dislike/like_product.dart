import 'package:seller_app/backend/databases/like_dislike_db.dart';

class LikeProductUseCase {
  final LikeDisLikeDatabase _database;

  LikeProductUseCase(this._database);

  Future<String> likeProduct({required String productId}) async =>
      await _database.likeProduct(productId: productId);
}
