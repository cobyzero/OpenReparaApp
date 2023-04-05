import 'dart:convert';

import 'package:openrepara_app/services/API.dart';
import 'package:openrepara_app/models/orderModel.dart';
import 'package:http/http.dart' as http;

class OrderService {
  static Future<List<OrderModel>> getOrder() async {
    Uri uri = API.getUri(path: "api/getOrder");

    http.Response response = await http.get(uri);

    List<OrderModel> list =
        (jsonDecode(response.body) as List).map((e) => OrderModel.fromJson(e)).toList();

    return list;
  }

  static Future<List<OrderModel>> getOrderForCode(String code) async {
    Uri uri = API.getUri(path: "api/getOrderForCode", queryParameters: {"code": code});

    http.Response response = await http.get(uri);

    List<OrderModel> list =
        (jsonDecode(response.body) as List).map((e) => OrderModel.fromJson(e)).toList();

    return list;
  }

  static Future<void> putOrderStatus(OrderModel orderModel) async {
    Uri uri = API.getUri(path: "api/putOrderStatus");

    var json = orderModel.toJson();

    await http.put(uri, body: jsonEncode(json));
  }

  static Future<void> deleteOrder(OrderModel orderModel) async {
    Uri uri = API.getUri(path: "api/deleteOrder");

    var json = orderModel.toJson();

    await http.delete(uri, body: jsonEncode(json));
  }

  static Future<void> addOrder(OrderModel orderModel) async {
    Uri uri = API.getUri(path: "api/addOrder");

    var json = orderModel.toJson();

    await http.post(uri, body: jsonEncode(json));
  }
}
