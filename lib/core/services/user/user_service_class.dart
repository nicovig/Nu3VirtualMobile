import 'package:nu3virtual/core/models/user_model.dart';

abstract class UserServiceStoreClass {
  Future<UserModel> getCurrentUser();
  Future<void> saveCurrentUser(UserModel currentUser);
}

abstract class UserServiceApiClass {
  Future<UserModel> create(UserModel userToCreate, String password);
}
