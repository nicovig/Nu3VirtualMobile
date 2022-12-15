import 'package:nu3virtual/core/services/authentication/models/authentication_response_models.dart';

abstract class AuthenticationService {
  Future<AuthenticationResponse> login(String login, String password);
}

abstract class AuthenticationStore {
  Future<String> getToken();
  Future<void> saveToken(String token);
}
