
abstract interface class IHttpClient{

  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters});
}