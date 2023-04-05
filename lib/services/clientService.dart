import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:openrepara_app/services/API.dart';
import 'package:openrepara_app/models/clientModel.dart';
import 'package:openrepara_app/viewModel/clientViewModel.dart';

class ClientService {
  static Future<List<ClientModel>> getClient() async {
    Uri uri = API.getUri(path: "api/getClient");

    http.Response response = await http.get(uri);

    List<ClientModel> list =
        (jsonDecode(response.body) as List).map((e) => ClientModel.fromJson(e)).toList();

    return list;
  }

  static Future<void> putClient(ClientViewModel clientViewModel) async {
    Uri uri = API.getUri(path: "api/putClient");

    String json = jsonEncode(clientViewModel.clientModel.toJson());

    await http.put(uri, body: json);
  }

  static Future<List<ClientModel>> getClientForCode(String code) async {
    Uri uri = API.getUri(path: "api/getClientForCode", queryParameters: {"code": code});

    http.Response response = await http.get(uri);

    List json = jsonDecode(response.body);

    List<ClientModel> list = json.map((e) => ClientModel.fromJson(e)).toList();

    return list;
  }

  static Future<void> deleteClient(ClientViewModel clientViewModel) async {
    Uri uri = API.getUri(path: "api/deleteClient");

    var json = clientViewModel.clientModel.toJson();

    await http.delete(uri, body: jsonEncode(json));
  }
}
