import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:seven_manager/src/model/cep_model.dart';
import 'package:seven_manager/src/repositories/cep_repository.dart';

class CepControllerYouChurch extends ChangeNotifier {
  CepControllerYouChurch({required CepRepository cepRepository})
      : _cepRepository = cepRepository;

  final CepRepository _cepRepository;
  CepModel? _cepModel;
  String message = '';

  CepModel? get cepModel => _cepModel;

  Future<void> zipCodeSearch(String? cep) async {
    // Verifica se o campo CEP está vazio
    if (cep == null || cep.isEmpty) {
      message = 'CEP não pode ser vazio';
      _cepModel = null;
      notifyListeners();
      return;
    }

    // Limpa o CEP removendo hífens e pontos
    String cep2 = cep.replaceAll("-", '').replaceAll(".", "");

    try {
      // Busca o CEP no repositório
      _cepModel = await _cepRepository.getCep(cep2);

      if (_cepModel != null && _cepModel!.logradouro.isNotEmpty) {
        // Se o CEP for encontrado e tiver logradouro, limpa a mensagem de erro
        message = '';
        log('CEP encontrado: ${_cepModel?.logradouro}');
      } else {
        // CEP não encontrado ou CEP inválido
        message = 'Endereço não localizado para o CEP informado';
        _cepModel = null;
      }
      notifyListeners();
    } catch (e, s) {
      // Trata erros durante a busca do CEP
      message = 'Erro ao buscar CEP: $e';
      log('Erro ao buscar CEP: $e $s');
      _cepModel = null;
      notifyListeners();
    }
  }
}
