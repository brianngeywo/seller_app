import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/backend/databases/product_db.dart';
import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/models/product_request_model.dart';
import 'package:seller_app/backend/models/user_model.dart';
import 'package:seller_app/backend/providers/users_provider.dart';
import 'package:seller_app/backend/use_cases/product_request/accept_product_request.dart';
import 'package:seller_app/backend/use_cases/products/read_single_product.dart';
import 'package:seller_app/local_data.dart';
import 'package:seller_app/view_product_page.dart';

import 'backend/providers/products_provider.dart';

class ViewProductRequestsScreen extends StatefulWidget {
  const ViewProductRequestsScreen({super.key});

  @override
  State<ViewProductRequestsScreen> createState() => _ViewProductRequestsScreenState();
}

class _ViewProductRequestsScreenState extends State<ViewProductRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    String selectedAction = "";
    var usersProvider = context.read<UsersProvider>();
    final acceptProductRequest = AcceptRequestProductUseCase(ProductsDatabase());
    final denyProductRequest = DenyRequestProductUseCase(ProductsDatabase());
    final getSingleProduct = ReadSingleProductUseCase(ProductsDatabase());
    final getAllProductRequests = GetAllProductRequestsUsingVendorIdUseCase(ProductsDatabase());
    return Scaffold(
      appBar: AppBar(
        title: Text('Your products requests'),
      ),
      body: FutureBuilder<List<ProductRequestModel>>(
          future: getAllProductRequests.call(vendorId: dummyUser.id),
          initialData: <ProductRequestModel>[],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                List<ProductRequestModel> productRequests =
                    snapshot.data.where((productRequest) => productRequest.vendorId == dummyUser.id).toList();
                return ListView.builder(
                  itemCount: productRequests.length,
                  itemBuilder: (context, index) {
                    final productRequest = productRequests[index];
                    return FutureBuilder<UserModel>(
                        future: usersProvider.readSingleUser(id: productRequest.requesterId),
                        builder: (context, snapshot) {
                          var user = snapshot.data!;
                          return ListTile(
                            title: Text(user.firstName + " " + user.lastName),
                            // subtitle: Text(product.description),
                            subtitle: Text('Phone: ${user.phoneNumber}'),
                            trailing: FutureBuilder(
                                future: getSingleProduct.call(productId: productRequest.productId),
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data != null) {
                                      ProductModel product = snapshot.data;
                                      return SizedBox(
                                        // height: 10,
                                        width: 100,
                                        child: DropdownButton(
                                          // value: selectedAction,
                                          icon: Icon(Icons.more_vert_sharp),
                                          items: productRequestActions
                                              .map((e) => DropdownMenuItem(
                                                  onTap: () {
                                                    switch (e.id) {
                                                      case "0":
                                                        Navigator.of(context).push(CupertinoPageRoute(
                                                            builder: (context) => ViewProductPage(product: product)));
                                                        break;
                                                      case "1":
                                                        acceptProductRequest.call(requestId: productRequest.id);
                                                        // Navigator.of(context).pop();
                                                        break;
                                                      case "2":
                                                        denyProductRequest.call(requestId: productRequest.id);
                                                        // Navigator.of(context).pop();
                                                        break;
                                                      default:
                                                        Navigator.of(context).pop();
                                                    }
                                                  },
                                                  value: e.id,
                                                  child: Text(e.title)))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedAction = value!;
                                            });
                                          },
                                        ),
                                      );
                                    } else {
                                      return Text("");
                                    }
                                  } else {
                                    return Text("");
                                  }
                                }),
                            onTap: () {},
                          );
                        });
                  },
                );
              } else {
                return Text("");
              }
            } else {
              return Text("");
            }
          }),
    );
  }
}

List<ActionModel> productRequestActions = [
  ActionModel(title: 'View Product', id: "0"),
  ActionModel(title: 'Accept', id: "1"),
  ActionModel(title: 'Deny', id: "2"),
];
