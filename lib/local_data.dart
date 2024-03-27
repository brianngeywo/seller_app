import 'package:seller_app/backend/databases/category_db.dart';
import 'package:seller_app/backend/databases/product_db.dart';
import 'package:seller_app/backend/databases/users_db.dart';
import 'package:seller_app/backend/models/user_model.dart';
import 'package:seller_app/backend/use_cases/categories/read_all_categories.dart';
import 'package:seller_app/backend/use_cases/product_request/accept_product_request.dart';
import 'package:seller_app/backend/use_cases/product_request/get_all_product_requests.dart';
import 'package:seller_app/backend/use_cases/products/read_all_products.dart';
import 'package:seller_app/backend/use_cases/products/read_single_product.dart';
import 'package:seller_app/backend/use_cases/users/create_user.dart';
import 'package:seller_app/backend/use_cases/users/edit_user.dart';
import 'package:seller_app/backend/use_cases/users/read_user.dart';

final dummyUser = UserModel(
    id: 'Rrw0OpSPQuB4MKlmrino',
    firstName: 'John',
    lastName: 'Doe',
    email: 'johndoe@example.com',
    phoneNumber: '1234567890',
    password: 'mypassword',
    username: "username");
final ReadSingleUserUseCase readSingleUser = ReadSingleUserUseCase(UsersDatabase());
final AcceptRequestProductUseCase acceptProductRequest = AcceptRequestProductUseCase(ProductsDatabase());
final DenyRequestProductUseCase denyProductRequest = DenyRequestProductUseCase(ProductsDatabase());
final ReadSingleProductUseCase getSingleProduct = ReadSingleProductUseCase(ProductsDatabase());
final GetAllProductRequestsUsingVendorIdUseCase getAllProductRequests = GetAllProductRequestsUsingVendorIdUseCase(ProductsDatabase());
final  GetAllRequestsUseCase getProductRequest = GetAllRequestsUseCase(ProductsDatabase());
final ReadAllcategoriesUseCase allCategories = ReadAllcategoriesUseCase(CategoriesDatabase());
final GetAllProductRequestsUsingVendorIdUseCase getAllProductRequestsUsingVendorIdUseCase = GetAllProductRequestsUsingVendorIdUseCase(ProductsDatabase());
final GetAllProductsUsingVendorIdUseCase getAllProductsUsingVendorIdUseCase =
    GetAllProductsUsingVendorIdUseCase(ProductsDatabase());
final GetAllClientsUsingVendorIdUseCase getAllClientsUsingVendorIdUseCase =
    GetAllClientsUsingVendorIdUseCase(ProductsDatabase());
final deleteSingleProductUseCase = DeleteSingleProductUseCase(ProductsDatabase());
final EditUserUseCase editUser = EditUserUseCase(UsersDatabase());
final CreateUserUseCase createUserUseCase = CreateUserUseCase(UsersDatabase());
