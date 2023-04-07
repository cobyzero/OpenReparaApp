class API {
  static String url = "openrepair.somee.com";
  static String urlLocal = "localhost";
  static int port = 7194;

  static Uri getUri({required String path, Map<String, dynamic>? queryParameters}) {
    return Uri(scheme: "http", host: url, path: path, queryParameters: queryParameters);
  }
}
