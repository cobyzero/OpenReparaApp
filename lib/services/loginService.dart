import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:openrepara_app/services/API.dart';
import 'package:openrepara_app/models/userModel.dart';

class LoginService {
  static Future<UserModel> checkLogin(String username, String password) async {
    Uri uri = API.getUri(
        path: "api/checkLogin", queryParameters: {"username": username, "password": password});

    http.Response response = await http.get(uri);

    UserModel model = UserModel.fromJson(jsonDecode(response.body));

    return model;
  }
}
