import 'package:nu3virtual/core/services/authentication/models/authentication_login_response_model.dart';
import 'package:nu3virtual/core/services/authentication/models/authentication_reset_password_response.model.dart';

abstract class AuthenticationService {
  Future<AuthenticationResponse> login(String login, String password);
  Future<ResetPasswordResponse> resetPassword(String email);
}

abstract class AuthenticationStore {
  Future<String> getToken();
  Future<void> saveToken(String token);
}
