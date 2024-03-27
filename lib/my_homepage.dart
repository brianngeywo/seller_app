import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/all_products.dart';
import 'package:seller_app/backend/databases/product_db.dart';
import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/models/product_request_model.dart';
import 'package:seller_app/backend/use_cases/products/read_all_products.dart';
import 'package:seller_app/backend/use_cases/products/read_single_product.dart';
import 'package:seller_app/constants.dart';
import 'package:seller_app/edit_seller_profile.dart';
import 'package:seller_app/local_data.dart';
import 'package:seller_app/upload_product.dart';
import 'package:seller_app/view_requests.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: const Text(
          "Soko seller",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello Brian",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Welcome back",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
                  children: [
                    Card(
                      color: Colors.white,
                      elevation: 5,
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bar_chart,
                                size: 20,
                                color: Colors.blue,
                              ),
                              FutureBuilder<List<ProductModel>>(
                                  future: getAllProductsUsingVendorIdUseCase.call(dummyUser.id),
                                  initialData: <ProductModel>[],
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data != null) {
                                        return Text(
                                          snapshot.data.length,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else {
                                        return Text("loading...");
                                      }
                                    } else {
                                      return Text("loading...");
                                    }
                                  }),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "All products",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 5,
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bar_chart,
                                size: 20,
                                color: Colors.blue,
                              ),
                              FutureBuilder<List<String>>(
                                  future: getAllClientsUsingVendorIdUseCase.call(vendorId: dummyUser.id),
                                  initialData: <String>[],
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data != null) {
                                        var users = [];
                                        var productRequests = snapshot.data;

                                        return Text(
                                          productRequests.length.toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else {
                                        return Text("loading...");
                                      }
                                    } else {
                                      return Text("loading...");
                                    }
                                  }),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "All Clients",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 5,
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bar_chart,
                                size: 20,
                                color: Colors.blue,
                              ),
                              FutureBuilder<List<ProductRequestModel>>(
                                  future: getAllProductRequestsUsingVendorIdUseCase
                                      .call(vendorId: dummyUser.id),
                                  initialData: <ProductRequestModel>[],
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data != null) {
                                        return Text(
                                          snapshot.data.length.toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else {
                                        return Text("loading...");
                                      }
                                    } else {
                                      return Text("loading...");
                                    }
                                  }),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "All Requests",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 5,
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bar_chart,
                                size: 20,
                                color: Colors.blue,
                              ),
                              FutureBuilder<List<ProductRequestModel>>(
                                  future: getAllProductRequestsUsingVendorIdUseCase
                                      .call(vendorId: dummyUser.id),
                                  initialData: <ProductRequestModel>[],
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data != null) {
                                        List<ProductRequestModel> requests = snapshot.data;
                                        return Text(
                                          requests.where((request) => request.isAccepted == true).length.toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else {
                                        return Text("loading...");
                                      }
                                    } else {
                                      return Text("loading...");
                                    }
                                  }),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "Accepted Requests",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Quick actions"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () => Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (context) => const ViewAllProductsScreen())),
                    child: Container(margin: const EdgeInsets.all(8.0), child: const Text("View all products")),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () =>
                        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const UploadProductPage())),
                    child: Container(margin: const EdgeInsets.all(8.0), child: const Text("Upload product")),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () => Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (context) => const ViewProductRequestsScreen())),
                    child: Container(margin: const EdgeInsets.all(8.0), child: const Text("View product requests")),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => EditSellerProfile(
                              user: dummyUser,
                            ))),
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      child: const Text("Edit seller profile"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
