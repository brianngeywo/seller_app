import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/backend/providers/products_provider.dart';

class ViewAllProductsScreen extends StatelessWidget {
  const ViewAllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = context.read<ProductsProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('appbarTitle'),
      ),
      body: FutureBuilder(
          future: productsProvider.getAllProducts(),
          initialData: productsProvider.products,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                var products = snapshot.data;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: Image.network(product.imageUrl),
                      title: Text(product.title),
                      subtitle: Text(product.description),
                      trailing: Text('\$${product.price}'),
                      onTap: () {
                        // Navigate to product detail view
                      },
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
