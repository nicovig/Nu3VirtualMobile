import 'package:http/http.dart' as http;

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';

class UserService extends UserServiceApiClass {
  static const Map<String, String> headers = {
    "Content-Type": "application/json"
  };
  static const hostedDeviceLocalhost = '10.0.2.2:';
  static const apiUrl = '44383';
  static const controllerName = 'User';
  static Uri url = Uri.https(hostedDeviceLocalhost + apiUrl, controllerName);

  @override
  Future<UserModel> create(UserModel userToCreate, String password) async {
    var response =
        await http.post(url, headers: headers, body: userToCreate.toJson());

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return UserModel(
        birthday: DateTime.now(),
        email: '',
        firstName: '',
        height: '',
        id: '',
        lastName: '',
        password: '',
        pseudo: '',
        weight: '0');
    ;
    //return response.body
  }
}
