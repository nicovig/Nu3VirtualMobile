import 'package:http/http.dart' as http;

import 'package:nu3virtual/core/models/user_model.dart';
import 'package:nu3virtual/core/services/user/user_service_class.dart';

class UserService extends UserServiceApiClass {
  static const hostedLocalhost = '10.0.2.2:';
  //static const apiUrl = 'localhost:44383';
  static const apiUrl = '44383';
  static const controllerName = 'User';

  @override
  Future<UserModel> create(UserModel userToCreate, String password) async {
    var test = Uri.https(hostedLocalhost + apiUrl, controllerName);
    var test2 = userToCreate.toJson();
    print(test);
    print(test2);
    var response = await http.post(test, body: userToCreate.toJson());
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return UserModel(
        birthday: DateTime.now().toString(),
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
