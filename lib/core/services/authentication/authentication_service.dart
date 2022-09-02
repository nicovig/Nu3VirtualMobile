abstract class AuthenticationService {
  Future<bool> login(String login, String password);
}

abstract class AuthenticationStore {
  Future<String> getToken();
  Future<void> saveToken(String token);
}
