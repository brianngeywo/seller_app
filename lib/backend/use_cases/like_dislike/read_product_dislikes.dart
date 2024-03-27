import 'package:seller_app/backend/databases/like_dislike_db.dart';
import 'package:seller_app/backend/models/like_dislike_model.dart';

class ReadProductDislikesUseCase {

  final LikeDisLikeDatabase _database;

  ReadProductDislikesUseCase(this._database);

  Future<List<LikeDislikeModel>> call({required String productId}) async {
    final result = await _database.readProductDislikes(productId: productId);
    var dislikes = result.map((e) => LikeDislikeModel.fromMap(e.data())).toList();
    return dislikes;
  }
}