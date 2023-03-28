import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:openrepara_app/controllers/API.dart';

class HomeController {
  static Future<List<String>> getData() async {
    Uri uri = API.getUri(path: "api/getData");

    http.Response response = await http.get(uri);

    List<String> data = response.body.replaceAll("[", "").replaceAll("]", "").split(",");

    print(data);
    return data;
  }
}
