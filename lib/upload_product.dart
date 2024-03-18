import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/backend/models/product_model.dart';



class UploadProductPage extends StatefulWidget {
  const UploadProductPage({Key? key}) : super(key: key);

  @override
  _UploadProductPageState createState() => _UploadProductPageState();
}

class _UploadProductPageState extends State<UploadProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  XFile? _imageFile;

  Future<void> _uploadProduct() async {
    if (_formKey.currentState!.validate()) {
      final productId = DateTime.now().millisecondsSinceEpoch.toString();
      final categoryId = 'defaultCategory'; // Set your desired category ID
      final vendorId = 'defaultVendor'; // Set your desired vendor ID

      // Upload the image to Firebase Storage
      final imageUrl = await _uploadImageToFirebaseStorage(productId);

      final product = ProductModel(
        id: productId,
        title: _titleController.text,
        description: _descriptionController.text,
        categoryId: categoryId,
        imageUrl: imageUrl,
        vendorId: vendorId,
        price: _priceController.text,
      );

      // Save the product to your database or perform any other necessary operations
      print('New product created: $product');
    }
  }

  Future<String> _uploadImageToFirebaseStorage(String productId) async {
    if (_imageFile == null) return '';

    final storageRef = FirebaseStorage.instance.ref().child('product_images/$productId');
    final uploadTask = storageRef.putData(await _imageFile!.readAsBytes());
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }

  void _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select Image'),
              ),
              const SizedBox(height: 16.0),
              _imageFile == null
                  ? const SizedBox.shrink()
                  : Image.file(
                File(_imageFile!.path),
                height: 200.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _uploadProduct,
                child: const Text('Upload Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}