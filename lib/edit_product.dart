import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/backend/databases/category_db.dart';
import 'package:seller_app/backend/databases/product_db.dart';
import 'package:seller_app/backend/models/category_model.dart';
import 'package:seller_app/backend/models/product_model.dart';
import 'package:seller_app/backend/use_cases/categories/read_all_categories.dart';
import 'package:seller_app/backend/use_cases/products/read_single_product.dart';
import 'package:seller_app/local_data.dart';

class EditProductPage extends StatefulWidget {
  final ProductModel productModel;

  const EditProductPage({Key? key, required this.productModel}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  XFile? _imageFile;

  Future<void> _uploadProduct({required ProductModel product}) async {
    EditSingleProductUseCase _editSingleProductUseCase = EditSingleProductUseCase(ProductsDatabase());
    if (_formKey.currentState!.validate()) {
      final productId = DateTime.now().millisecondsSinceEpoch.toString();
      final vendorId = dummyUser.id; // Set your desired vendor ID
      // final vendorId = firebaseAuth.currentUser!.uid; // Set your desired vendor ID

      // Upload the image to Firebase Storage
      final imageUrl = await _uploadImageToFirebaseStorage(productId);
      await _editSingleProductUseCase.call(
          product: ProductModel(
              id: product.id,
              title: product.title,
              description: product.description,
              categoryId: product.categoryId,
              imageUrl: imageUrl,
              vendorId: product.vendorId,
              price: product.price));
      // Save the product to your database or perform any other necessary operations
      print('New product created: $productId');
      print('New image created: $imageUrl');
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
  void initState() {
    _titleController = TextEditingController(text: widget.productModel.title);
    _descriptionController = TextEditingController(text: widget.productModel.description);
    _priceController = TextEditingController(text: widget.productModel.price);
    super.initState();
  }

  String selectedCategory = "";

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
              FutureBuilder<List<CategoryModel>>(
                  future: allCategories.call(),
                  initialData: <CategoryModel>[],
                  builder: (context, snapshot) {
                    return DropdownButtonFormField(
                        items: snapshot.data!.map((e) => DropdownMenuItem(child: Text(e.name), value: e.id)).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        });
                  }),
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
                onPressed: () => _uploadProduct(
                    product: ProductModel(
                  id: widget.productModel.id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  categoryId: selectedCategory,
                  imageUrl: '',
                  vendorId: dummyUser.id,
                  price: _priceController.text,
                )),
                child: const Text('Upload Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
