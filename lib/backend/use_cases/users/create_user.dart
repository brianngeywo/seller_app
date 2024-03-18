import 'package:seller_app/backend/databases/users_db.dart';
import 'package:seller_app/backend/models/user_model.dart';

class CreateUserUseCase {
  final UsersDatabase _userDatabase;

  CreateUserUseCase(this._userDatabase);

  Future<void> call(UserModel user) async {
    final result = await _userDatabase.createUser(user: user.toMap());
    // return UserModel.fromMap(result.data()!);
  return result;
  }
}
