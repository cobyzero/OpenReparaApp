import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:openrepara_app/controllers/API.dart';
import 'package:openrepara_app/models/clientesModel.dart';

class ClientesController {
  static Future<List<ClientesModel>> getData() async {
    Uri uri = API.getUri(path: "api/getClientes");

    http.Response response = await http.get(uri);

    List<ClientesModel> posts =
        (jsonDecode(response.body) as List).map((e) => ClientesModel.fromJson(e)).toList();

    return posts;
  }

  static Future<void> putCliente(ClientesModel clientesModel) async {
    Uri uri = API.getUri(path: "api/putCliente");

    String json = jsonEncode(clientesModel.toJson());

    await http.put(uri, body: json);
  }

  static Future<List<ClientesModel>> getClienteForCode(String code) async {
    Uri uri = API.getUri(path: "api/getClienteForCode", queryParameters: {"code": code});

    http.Response response = await http.get(uri);
    print(code);
    List<ClientesModel> posts =
        (jsonDecode(response.body) as List).map((e) => ClientesModel.fromJson(e)).toList();

    return posts;
  }

  static Future<void> deleteCliente(ClientesModel clientesModel) async {
    Uri uri = API.getUri(path: "api/deleteCliente");

    var json = clientesModel.toJson();

    await http.delete(uri, body: jsonEncode(json));
  }
}
