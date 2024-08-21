import 'package:seven_manager/src/interfaces/http_client.dart';
import 'package:seven_manager/src/model/cep_model.dart';

class CepRepository {
  CepRepository({required IHttpClient httpClient}) : _httpClient = httpClient;

  final IHttpClient _httpClient;

  Future<CepModel> getCep(String cep) async {
    final response =
        await _httpClient.get('https://viacep.com.br/ws/$cep/json/');
    // final Map<String, dynamic> data = await response.data;
    return CepModel.fromMap(response);
  }
}

//fromJson(response.data)
