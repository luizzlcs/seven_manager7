import 'package:dio/dio.dart';
import 'package:seven_manager/src/interfaces/http_client.dart';


class DioHttpClient implements IHttpClient {
  DioHttpClient({required Dio dio}): _dio = dio;
  
  final Dio _dio;

  @override
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response.data;
    } catch (e) {
      // Tratar erros aqui
      
      rethrow;
    }
  }
}
