class ProductRequestModel {
  final String id;
  final String productId;
  final String userId;
  final bool isAccepted;
  final bool isDenied;

  ProductRequestModel(
      {required this.id,
      required this.productId,
      required this.userId,
      required this.isAccepted,
      required this.isDenied});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'productId': this.productId,
      'userId': this.userId,
      'isAccepted': this.isAccepted,
      'isDenied': this.isDenied,
    };
  }

  factory ProductRequestModel.fromMap(Map<String, dynamic> map) {
    return ProductRequestModel(
      id: map['id'],
      productId: map['productId'],
      userId: map['userId'],
      isAccepted: map['isAccepted'],
      isDenied: map['isDenied'],
    );
  }
}
