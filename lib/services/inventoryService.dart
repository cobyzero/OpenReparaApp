import 'dart:convert';

import 'package:openrepara_app/services/API.dart';
import 'package:openrepara_app/models/inventoryModel.dart';
import 'package:http/http.dart' as http;

class InventoryService {
  static Future<List<InventoryModel>> getInventory() async {
    Uri uri = API.getUri(path: "api/getInventory");

    http.Response response = await http.get(uri);

    List<InventoryModel> posts =
        (jsonDecode(response.body) as List).map((e) => InventoryModel.fromJson(e)).toList();

    return posts;
  }

  static Future<List<InventoryModel>> getInventoryForCode(String code) async {
    Uri uri = API.getUri(path: "api/getInventoryForCode", queryParameters: {"code": code});

    http.Response response = await http.get(uri);

    List<InventoryModel> posts =
        (jsonDecode(response.body) as List).map((e) => InventoryModel.fromJson(e)).toList();

    return posts;
  }

  static Future<void> deleteInventoryForCode(InventoryModel inventoryModel) async {
    Uri uri = API.getUri(path: "api/deleteInventoryForCode");
    var json = inventoryModel.toJson();

    await http.delete(uri, body: jsonEncode(json));
  }

  static Future<void> putInventory(InventoryModel inventoryModel) async {
    Uri uri = API.getUri(path: "api/putInventory");
    var json = inventoryModel.toJson();

    await http.put(uri, body: jsonEncode(json));
  }
}
