import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:seven_manager/src/model/cep_model.dart';
import 'package:seven_manager/src/repositories/cep_repository.dart';

class CepController extends ChangeNotifier {
  CepController({required CepRepository cepRepository})
      : _cepRepository = cepRepository;

  final CepRepository _cepRepository;
  CepModel? _cepModel;

  CepModel get cepModel => _cepModel!;

  // final CepRepository _cepRepository = getIt();

  Future<void> buscarCep(String? cep) async {
    try {
      if(cep != null){
        _cepModel = await _cepRepository.getCep(cep);
      log('CEP: ${_cepModel!.logradouro}');
      notifyListeners();

      }
      
    } catch (e, s) {
      // Tratar erros aqui
      print('Erro ao buscar CEP: $e $s');
    }
  }
}
