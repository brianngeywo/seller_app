class ProductRequestModel {
  final String id;
  final String productId;
  final String requesterId;
  final String vendorId;
  final bool isAccepted;
  final bool isDenied;

  ProductRequestModel(
      {required this.id,
      required this.productId,
      required this.requesterId,
      required this.vendorId,
      required this.isAccepted,
      required this.isDenied});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'productId': this.productId,
      'requesterId': this.requesterId,
      'vendorId': this.vendorId,
      'isAccepted': this.isAccepted,
      'isDenied': this.isDenied,
    };
  }

  factory ProductRequestModel.fromMap(Map<String, dynamic> map) {
    return ProductRequestModel(
      id: map['id'],
      productId: map['productId'],
      requesterId: map['requesterId'],
      vendorId: map['vendorId'],
      isAccepted: map['isAccepted'],
      isDenied: map['isDenied'],
    );
  }
}
