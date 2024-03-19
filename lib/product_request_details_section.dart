import 'package:flutter/material.dart';
import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/models/product_request_model.dart';


  Widget productDetailView({required ProductModel product, required List<ProductRequestModel> requests}) {
    // final productRequests = requests
    //     .where((request) => request.productId == product.id)
    //     .toList();

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              'Number of Requests: ${requests.length}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
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
