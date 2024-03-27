import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/backend/databases/product_db.dart';
import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/use_cases/products/read_all_products.dart';
import 'package:seller_app/backend/use_cases/products/read_single_product.dart';
import 'package:seller_app/edit_product.dart';
import 'package:seller_app/local_data.dart';
import 'package:seller_app/view_product_page.dart';

class ViewAllProductsScreen extends StatefulWidget {
  const ViewAllProductsScreen({super.key});

  @override
  State<ViewAllProductsScreen> createState() => _ViewAllProductsScreenState();
}

class _ViewAllProductsScreenState extends State<ViewAllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    String selectedAction = "";
   return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
      ),
      body: FutureBuilder<List<ProductModel>>(
          future: getAllProductsUsingVendorIdUseCase.call(dummyUser.id),
          initialData: <ProductModel>[] ,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                List<ProductModel> products =
                    snapshot.data;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: Image.network(product.imageUrl),
                      title: Text(product.title),
                      // subtitle: Text(product.description),
                      subtitle: Text('kes ${product.price}'),
                      trailing: SizedBox(
                        // height: 10,
                        width: 100,
                        child: DropdownButton(
                          // value: selectedAction,
                          icon: Icon(Icons.more_vert_sharp),
                          items: productActions
                              .map(
                                (e) => DropdownMenuItem(
                                    onTap: () {
                                      switch (e.id) {
                                        case "1":
                                          Navigator.of(context).push(CupertinoPageRoute(
                                              builder: (context) => EditProductPage(productModel: product)));
                                          break;
                                        case "2":
                                          deleteSingleProductUseCase.call(productId: e.id);
                                          Navigator.of(context).pop();
                                          break;
                                        default:
                                          Navigator.of(context).pop();
                                      }
                                    },
                                    value: e.id,
                                    child: Text(e.title)),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedAction = value!;
                            });
                          },
                        ),
                      ),
                      onTap: () {
                        // Navigate to product detail view
                        Navigator.of(context)
                            .push(CupertinoPageRoute(builder: (context) => ViewProductPage(product: product)));
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

List<ActionModel> productActions = [
  ActionModel(title: 'Edit', id: "1"),
  ActionModel(title: 'Delete', id: "2"),
];
