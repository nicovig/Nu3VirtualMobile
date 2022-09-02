import 'package:nu3virtual/core/models/user_model.dart';

abstract class UserStore {
  Future<void> deleteCurrentUser();
  Future<UserModel> getCurrentUser();
  Future<void> saveCurrentUser(String currentUserString);
}

abstract class UserService {
  Future<bool> create(UserModel userToCreate, String password);
}
