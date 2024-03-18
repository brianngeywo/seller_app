 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final productsCollection = FirebaseFirestore.instance.collection("products");
final categoriesCollection = FirebaseFirestore.instance.collection("categories");
final usersCollection = FirebaseFirestore.instance.collection("users");
final likeDislikesCollection = FirebaseFirestore.instance.collection("likeDislikes");
final productRequestsCollection = FirebaseFirestore.instance.collection("productRequests");
final firebaseAuth = FirebaseAuth.instance;