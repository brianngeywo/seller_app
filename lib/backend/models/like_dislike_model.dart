class LikeDislikeModel {
  final String id;
  final String userId;
  final String productId;
  final bool liked;

  const LikeDislikeModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.liked,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'liked': liked,
    };
  }

  factory LikeDislikeModel.fromMap(Map<String, dynamic> map) {
    return LikeDislikeModel(
      id: map['id'],
      userId: map['userId'],
      productId: map['productId'],
      liked: map['liked'],
    );
  }
}
