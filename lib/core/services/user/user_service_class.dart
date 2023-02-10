import 'package:nu3virtual/core/models/user_model.dart';

abstract class UserStore {
  Future<void> deleteCurrentUser();
  Future<UserModel> getCurrentUser();
  Future<void> saveCurrentUser(String currentUserString);
}

abstract class UserService {
  Future<bool> changePassword(
      int userId, String oldPassword, String newPassword);
  Future<bool> create(UserModel userToCreate, String password);
  Future<bool> isEmailUsable(String email);
  Future<String> update(UserModel userToUpdate, String password);
}
