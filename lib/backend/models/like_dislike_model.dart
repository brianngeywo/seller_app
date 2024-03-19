class LikeDislikeModel {
  final String id;
  final String userId;
  final String productId;
  final String vendorId;
  final bool liked;

  const LikeDislikeModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.vendorId,
    required this.liked,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'vendorId': vendorId,
      'liked': liked,
    };
  }

  factory LikeDislikeModel.fromMap(Map<String, dynamic> map) {
    return LikeDislikeModel(
      id: map['id'],
      userId: map['userId'],
      productId: map['productId'],
      vendorId: map['vendorId'],
      liked: map['liked'],
    );
  }
}
