import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/backend/providers/categories_provider.dart';
import 'package:seller_app/backend/providers/like_dislikes_provider.dart';
import 'package:seller_app/backend/providers/products_provider.dart';
import 'package:seller_app/backend/providers/users_provider.dart';
import 'package:seller_app/injection_container.dart';
import 'package:seller_app/my_homepage.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetItInjectionContainer().registerDependencies(); // Await if it's async
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => getIt<UsersProvider>()),
        ChangeNotifierProvider(create: (context) => getIt<CategoriesProvider>()),
        ChangeNotifierProvider(create: (context) => getIt<LikeDislikesProvider>()),
        ChangeNotifierProvider(create: (context) => getIt<ProductsProvider>()),
      ],
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    ),
    );
  }
}
