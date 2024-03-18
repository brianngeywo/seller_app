import 'package:flutter/material.dart';
import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/models/product_request_model.dart';


class ProductDetailView extends StatefulWidget {
  final ProductModel product;
  final List<ProductRequestModel> requests;

  const ProductDetailView({
    Key? key,
    required this.product,
    required this.requests,
  }) : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    final productRequests = widget.requests
        .where((request) => request.productId == widget.product.id)
        .toList();

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display product details...

            const SizedBox(height: 16.0),
            const Text(
              'Product Requests',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Number of Requests: ${productRequests.length}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: productRequests.length,
              itemBuilder: (context, index) {
                final request = productRequests[index];
                return ListTile(
                  title: Text('Request ID: ${request.id}'),
                  subtitle: Text('User ID: ${request.userId}'),
                );
              },
            ),
          ],
        ),

    );
  }
}