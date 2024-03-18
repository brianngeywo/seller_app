import 'package:flutter/material.dart';

class EditSellerProfile extends StatelessWidget {
  const EditSellerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('appbarTitle'),
        ),
        body: Center(child: const Text("edit seller profile")));
  }
}
