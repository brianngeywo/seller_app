import 'package:seller_app/backend/databases/users_db.dart';
import 'package:seller_app/backend/models/user_model.dart';

class EditUserUseCase {
  final UsersDatabase _userDatabase;

  EditUserUseCase(this._userDatabase);

  Future<void> call(UserModel user) async {
    final result = await _userDatabase.editUser(user: user.toMap());
    // return UserModel.fromMap(result.data()!);
    return result;
  }
}