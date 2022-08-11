import 'package:nu3virtual/core/models/user_model.dart';

abstract class AuthenticationService {
  Future<UserModel> login(String login, String password);
}
