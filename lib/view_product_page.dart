import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/models/product_request_model.dart';
import 'package:seller_app/backend/providers/products_provider.dart';
import 'package:seller_app/product_request_details_section.dart';

class ViewProductPage extends StatelessWidget {
  final ProductModel product;
  const ViewProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    ProductsProvider productsProvider = context.read<ProductsProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
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
              'Price:  Kes ${product.price}',
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
            FutureBuilder<List<ProductRequestModel>>(
                future: productsProvider.getAllProductRequests(productId: product.id),
                initialData: productsProvider.productRequests,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      List<ProductRequestModel> productRequestList = snapshot.data;
                      return ProductDetailView(
                        product: product,
                        requests: productRequestList,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }else {
                    return LinearProgressIndicator();
                  }
                }),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
