import 'package:seller_app/backend/databases/like_dislike_db.dart';
import 'package:seller_app/backend/models/like_dislike_model.dart';

class ReadProductLikesUseCase {
  final LikeDisLikeDatabase _database;

  ReadProductLikesUseCase(this._database);

  Future<List<LikeDislikeModel>> readProductLikes({required String productId}) async {
    final result=  await _database.readProductLikes(productId: productId);
    var likes = result.map((e) => LikeDislikeModel.fromMap(e.data())).toList();
    return likes;
  }
}
