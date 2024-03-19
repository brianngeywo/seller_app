import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/backend/databases/product_db.dart';
import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/providers/products_provider.dart';
import 'package:seller_app/backend/use_cases/products/read_all_products.dart';
import 'package:seller_app/constants.dart';
import 'package:seller_app/view_product_page.dart';

class ViewAllProductsScreen extends StatelessWidget {
  const ViewAllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getAllProducts = ReadAllProductsUseCase(ProductsDatabase());
    return Scaffold(
      appBar: AppBar(
        title: Text('appbarTitle'),
      ),
      body: FutureBuilder<List<ProductModel>>(
          future: getAllProducts.call(),
          initialData: <ProductModel>[],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                var products = snapshot.data.where((product) => product.vendorId == firebaseAuth.currentUser!.uid)
                    .toList();
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: Image.network(product.imageUrl),
                      title: Text(product.title),
                      // subtitle: Text(product.description),
                      subtitle: Text('kes ${product.price}'),
                      onTap: () {
                        // Navigate to product detail view
                        Navigator.of(context).push(CupertinoPageRoute(builder: (context) =>
                        ViewProductPage(product: product)));
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
