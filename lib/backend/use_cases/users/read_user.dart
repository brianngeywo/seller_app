import 'package:seller_app/backend/databases/users_db.dart';
import 'package:seller_app/backend/models/user_model.dart';

class ReadSingleUserUseCase {
  final UsersDatabase _userDatabase;
  ReadSingleUserUseCase(this._userDatabase);

  Future<UserModel> call({required String id}) async {
    final result = await _userDatabase.getUserInfor(id:id);
    return UserModel.fromMap(result.data()!);
  }
}