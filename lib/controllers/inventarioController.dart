import 'dart:convert';

import 'package:openrepara_app/controllers/API.dart';
import 'package:openrepara_app/models/inventarioModel.dart';
import 'package:http/http.dart' as http;

class InventarioController {
  static Future<List<InventarioModel>> getInventario() async {
    Uri uri = API.getUri(path: "api/getInventario");

    http.Response response = await http.get(uri);

    List<InventarioModel> posts =
        (jsonDecode(response.body) as List).map((e) => InventarioModel.fromJson(e)).toList();

    return posts;
  }

  static Future<List<InventarioModel>> getClienteForCode(String code) async {
    Uri uri = API.getUri(path: "api/getInventarioForCode", queryParameters: {"code": code});

    http.Response response = await http.get(uri);

    List<InventarioModel> posts =
        (jsonDecode(response.body) as List).map((e) => InventarioModel.fromJson(e)).toList();

    return posts;
  }
}
