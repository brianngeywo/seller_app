import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/backend/databases/product_db.dart';
import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/models/product_request_model.dart';
import 'package:seller_app/backend/models/user_model.dart';
import 'package:seller_app/backend/providers/users_provider.dart';
import 'package:seller_app/backend/use_cases/product_request/get_all_product_requests.dart';

class ViewProductPage extends StatelessWidget {
  final ProductModel product;

  const ViewProductPage({super.key, required this.product});


  @override
  Widget build(BuildContext context) {
    String selectedAction = "";
    UsersProvider userProvider = context.read<UsersProvider>();
    var getProductRequest = GetAllRequestsUseCase(ProductsDatabase());
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
                future: getProductRequest.call(productId: product.id),
                initialData: <ProductRequestModel>[].where((request) => request.productId == product.id).toList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      List<ProductRequestModel> requests =
                          snapshot.data.where((request) => request.productId == product.id).toList();

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(),
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
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: requests.length,
                              itemBuilder: (context, index) {
                                final request = requests[index];
                                print("user id: " + request.userId);
                                return FutureBuilder<UserModel>(
                                    future: userProvider.readSingleUser(id: request.userId),
                                    initialData: UserModel.empty(),
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data != null) {
                                          UserModel user = snapshot.data;
                                          return ListTile(
                                            title: Text(user.firstName + " " + user.lastName),
                                            subtitle: Text(user.phoneNumber),
                                            trailing: SizedBox(
                                              // height: 10,
                                              width: 100,
                                              child: DropdownButtonFormField(
                                                value: selectedAction,
                                                icon: Icon(Icons.more_vert_sharp),
                                                items: actions.map(
                                                  (e) => DropdownMenuItem(child: Text(e.title)),
                                                ).toList(),
                                                onChanged: (value) {
                                                selectedAction =   value.id;
                                                },
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const Text("fetching data....");
                                        }
                                      } else {
                                        return const Text("fetching data....");
                                      }
                                    });
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Text("fetching data....");
                    }
                  } else {
                    return const Text("fetching data....");
                  }
                }),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

List<ActionModel> actions = [
  ActionModel(title: 'Accept', id: "0"),
  ActionModel(title: 'Deny', id: "1"),
  ActionModel(title: 'Delete', id: "1"),
];

class ActionModel {
  final String title;
  final String id;

  ActionModel({required this.title, required this.id});
}
