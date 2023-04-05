import 'package:http/http.dart' as http;
import 'package:openrepara_app/services/API.dart';

class HomeService {
  static Future<List<String>> getHome() async {
    Uri uri = API.getUri(path: "api/getHome");

    http.Response response = await http.get(uri);

    List<String> data = response.body.replaceAll("[", "").replaceAll("]", "").split(",");

    return data;
  }
}
