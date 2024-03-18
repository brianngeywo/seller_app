import 'package:flutter/material.dart';

class ViewProductRequestsScreen extends StatelessWidget {
  const ViewProductRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('appbarTitle'),
        ),
        body: Center(child: const Text("view product requests")));
  }
}
