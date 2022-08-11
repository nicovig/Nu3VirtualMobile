import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/authentication/authentication_service.dart';

class AuthenticationServiceCaller extends AuthenticationService {
  @override
  Future<UserModel> login(String login, String password) async {
    return UserModel(
        birthday: DateTime.now(),
        email: '',
        firstName: '',
        height: 0,
        id: 0,
        lastName: '',
        password: '',
        pseudo: '',
        weight: 0);
  }
}
