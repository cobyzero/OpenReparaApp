class API {
  static String url = "localhost";
  static int port = 7194;

  static Uri getUri({required String path, Map<String, dynamic>? queryParameters}) {
    return Uri(
        scheme: "https", host: API.url, port: port, path: path, queryParameters: queryParameters);
  }
}
