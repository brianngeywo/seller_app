import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/models/product_request_model.dart';
import 'package:seller_app/backend/models/user_model.dart';
import 'package:seller_app/backend/providers/users_provider.dart';

class ProductRequestDetailView extends StatelessWidget {
  final ProductModel product;
  final List<ProductRequestModel> requests;

  const ProductRequestDetailView({
    super.key,
    required this.product,
    required this.requests,
  });

  @override
  Widget build(BuildContext context) {
    UsersProvider userProvider = context.read<UsersProvider>();
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
              print(request.userId);
              return FutureBuilder<UserModel>(
                  future: userProvider.readSingleUser(id: request.userId),
                  initialData: UserModel.empty(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        UserModel user = snapshot.data;
                        return ListTile(
                          title: Text(user.firstName + user.lastName),
                          subtitle: Text(user.phoneNumber),
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
  }
}
