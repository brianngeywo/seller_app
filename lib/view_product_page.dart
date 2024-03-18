import 'package:flutter/material.dart';
import 'package:seller_app/backend/models/product_model.dart';

class ViewProductPage extends StatelessWidget {
  final ProductModel product;
  const ViewProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Price: \$${product.price}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add to cart or purchase logic
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
