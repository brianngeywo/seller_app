import 'package:seller_app/backend/databases/users_db.dart';
import 'package:seller_app/backend/models/user_model.dart';
import 'package:seller_app/backend/use_cases/users/create_user.dart';
import 'package:seller_app/backend/use_cases/users/read_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UsersProvider extends ChangeNotifier {
  final CreateUserUseCase _createUserUseCase;
  final ReadSingleUserUseCase _readSingleUserUseCase;
  final CheckUserInDatabaseUseCase _checkUserInDatabaseUseCase;
  final SignUpWithEmailAndPasswordUseCase _signUpUseCase;
  final SignInUserUseCase _signInUserUseCase;
  bool _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  bool get isLoggedIn => _isLoggedIn;

  UsersProvider({
    required SignUpWithEmailAndPasswordUseCase signUpWithEmailAndPasswordUseCase,
    required CreateUserUseCase createUserUseCase,
    required ReadSingleUserUseCase readSingleUserUseCase,
    required CheckUserInDatabaseUseCase checkUserInDatabaseUseCase,
    required SignInUserUseCase signInUserUseCase,
  })  : _createUserUseCase = createUserUseCase,
        _signUpUseCase = signUpWithEmailAndPasswordUseCase,
        _checkUserInDatabaseUseCase = checkUserInDatabaseUseCase,
        _signInUserUseCase = signInUserUseCase,
        _readSingleUserUseCase = readSingleUserUseCase,
        _isLoggedIn = false;

  Future<void> createUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    await _createUserUseCase
        .call(UserModel(id: const Uuid().v8(), firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, password: password));
    notifyListeners();
  }

  Future<UserModel?> signUserInDatabase({
    required String email,
    required String password,
  }) async {
    final result = await _signInUserUseCase.call(email: email, password: password);
    if (result != null) {
      isLoggedIn = true;
      notifyListeners();
      return result;
    } else {
      isLoggedIn = false;
      notifyListeners();
      return null;
    }
  }

  Future<UserModel?> checkUserInDatabase({
    required String email,
    required String password,
  }) async {
    final result = await _checkUserInDatabaseUseCase.call(email: email, password: password);
    if (result != null) {
      isLoggedIn = true;
      notifyListeners();
      return result;
    } else {
      isLoggedIn = false;
      notifyListeners();
      return null;
    }
  }

  Future<UserModel> readSingleUser({required String id}) async => await _readSingleUserUseCase.call(id: id);

  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password, required String firstName, required String lastName, required String phoneNumber}) async {
    final result = await _signUpUseCase(password: password, email: email);
    if (result != null) {
      await _createUserUseCase.call(
          UserModel(id: result.user!.uid, firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, password: password));
      isLoggedIn = true;
      notifyListeners();
    } else {
      isLoggedIn = false;
      notifyListeners();
    }
  }
}

class SignUpWithEmailAndPasswordUseCase {
  final UsersDatabase _userDatabase;

  SignUpWithEmailAndPasswordUseCase(this._userDatabase);

  Future<UserCredential?> call({required String password, required String email}) async {
    final result = await _userDatabase.signUpWithEmailAndPasswordUseCase(password: password, email: email);

    return result;
  }
}

class CheckUserInDatabaseUseCase {
  final UsersDatabase _userDatabase;

  CheckUserInDatabaseUseCase(this._userDatabase);

  Future<UserModel?> call({required String password, required String email}) async {
    final result = await _userDatabase.checkUserInDatabaseUseCase(password: password, email: email);
    return UserModel.fromMap(result!.data());
  }
}

class SignInUserUseCase {
  final UsersDatabase _userDatabase;

  SignInUserUseCase(this._userDatabase);

  Future<UserModel?> call({required String password, required String email}) async {
    final result = await _userDatabase.signUserInDatabaseUseCase(password: password, email: email);
    if (result != null) {
      return UserModel.fromMap(result.data()!);
    } else {
      return null;
    }
  }
}
