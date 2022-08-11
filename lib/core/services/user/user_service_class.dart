import 'package:nu3virtual/core/models/user_model.dart';

abstract class UserServiceStoreClass {
  Future<UserModel> getCurrentUser();
  Future<void> saveCurrentUser(String currentUserString);
}

abstract class UserServiceApiClass {
  Future<bool> create(UserModel userToCreate, String password);
}
