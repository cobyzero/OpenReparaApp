import 'dart:convert';

import 'package:openrepara_app/models/saleModel.dart';
import 'package:openrepara_app/services/API.dart';
import 'package:http/http.dart' as http;

class SaleService {
  static Future<List<SaleModel>> getSale() async {
    var uri = API.getUri(path: "api/getSale");

    http.Response response = await http.get(uri);

    List json = jsonDecode(response.body);

    List<SaleModel> list = json.map((e) => SaleModel.fromJson(e)).toList();

    return list;
  }
}
