import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/all_products.dart';
import 'package:seller_app/edit_seller_profile.dart';
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
                      child: const Column(
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
                              Text(
                                "20",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
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
                      child: const Column(
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
                              Text(
                                "20",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
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
                      child: const Column(
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
                              Text(
                                "20",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
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
                      child: const Column(
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
                              Text(
                                "20",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
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
                    onPressed: () =>
                        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const ViewAllProductsScreen())),
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
                    onPressed: () =>
                        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const ViewProductRequestsScreen())),
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
                    onPressed: () =>
                        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const EditSellerProfile())),
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
