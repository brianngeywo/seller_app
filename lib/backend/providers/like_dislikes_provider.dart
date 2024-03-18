import 'package:seller_app/backend/models/like_dislike_model.dart';
import 'package:seller_app/backend/use_cases/like_dislike/dislike_product.dart';
import 'package:seller_app/backend/use_cases/like_dislike/like_product.dart';
import 'package:seller_app/backend/use_cases/like_dislike/read_product_dislikes.dart';
import 'package:seller_app/backend/use_cases/like_dislike/read_product_likes.dart';
import 'package:seller_app/backend/use_cases/like_dislike/stream_product_likes_count.dart';
import 'package:flutter/material.dart';

class LikeDislikesProvider with ChangeNotifier {
  final LikeProductUseCase _likeProductUseCase;
  final DislikeProductUseCase _dislikeProductUseCase;
  final ReadProductLikesUseCase _readProductLikesUseCase;
  final ReadProductDislikesUseCase _readProductDislikesUseCase;
  final GetProductLikesCountUseCase _getProductLikesCountUseCase;
  final GetProductDisLikesCountUseCase _getProductDisLikesCountUseCase;

  LikeDislikesProvider({
    required LikeProductUseCase likeProductUseCase,
    required DislikeProductUseCase dislikeProductUseCase,
    required ReadProductLikesUseCase readProductLikesUseCase,
    required ReadProductDislikesUseCase readProductDislikesUseCase,
    required GetProductLikesCountUseCase getProductLikesCountUseCase,
    required GetProductDisLikesCountUseCase getProductDisLikesCountUseCase,
  })  : _likeProductUseCase = likeProductUseCase,
        _dislikeProductUseCase = dislikeProductUseCase,
        _readProductLikesUseCase = readProductLikesUseCase,
        _readProductDislikesUseCase = readProductDislikesUseCase,
        _getProductLikesCountUseCase = getProductLikesCountUseCase,
        _getProductDisLikesCountUseCase = getProductDisLikesCountUseCase;

  // Future<void> likeDislikePost({required String productId, required bool isLike}) async {
  //   if (isLike) {
  //     await _likeProductUseCase.likeProduct(productId: productId, userId: "upAplozfZgXXapAV3nxM");
  //   } else {
  //     await _dislikeProductUseCase.dislikeProduct(productId: productId, userId: FirebaseAuth.instance.currentUser!.uid);
  //   }
  //   notifyListeners();
  // }
  //
  Future<String> likeProduct({
    required String productId,
  }) async =>
      await _likeProductUseCase.likeProduct(productId: productId);

  Future<void> dislikeProduct({
    required String productId,
  }) async =>
      await _dislikeProductUseCase.dislikeProduct(productId: productId);

  Future<List<LikeDislikeModel>> readProductLikes(String productId) async {
    final result = await _readProductLikesUseCase.readProductLikes(productId: productId);
    return result;
  }

  Future<List<LikeDislikeModel>> readProductDislikes(String productId) async {
    final result = await _readProductDislikesUseCase.readProductDislikes(productId: productId);
    return result;
  }

  Stream<int> getProductLikesCount({required String productId}) {
    final likesStream = _getProductLikesCountUseCase.getProductLikesCount(productId);
    return likesStream;
  }

  Stream<int> getProductDisLikesCount({required String productId}) {
    final likesStream = _getProductDisLikesCountUseCase.getProductDisLikesCount(productId);
    return likesStream;
  }
}
