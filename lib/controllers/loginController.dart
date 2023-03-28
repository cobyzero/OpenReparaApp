import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:openrepara_app/controllers/API.dart';
import 'package:openrepara_app/models/UsersModel.dart';

class LoginController {
  static Future<UsersModel> checkLogin(String username, String password) async {
    Uri uri = API.getUri(
        path: "api/checkLogin", queryParameters: {"username": username, "password": password});

    http.Response response = await http.get(uri);
    UsersModel model = UsersModel.fromJson(jsonDecode(response.body));

    return model;
  }
}
