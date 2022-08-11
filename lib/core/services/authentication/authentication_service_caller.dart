import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/authentication/authentication_service.dart';

class AuthenticationServiceCaller extends AuthenticationService {
  @override
  Future<UserModel> login(String login, String password) async {
    return UserModel(
        birthday: DateTime.now().toString(),
        email: '',
        firstName: '',
        height: '',
        id: '',
        lastName: '',
        password: '',
        pseudo: '',
        weight: '');
  }
}
