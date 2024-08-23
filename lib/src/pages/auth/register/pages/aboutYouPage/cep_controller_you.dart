import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:seven_manager/src/model/cep_model.dart';
import 'package:seven_manager/src/repositories/cep_repository.dart';

class CepControllerYou extends ChangeNotifier {
  CepControllerYou({required CepRepository cepRepository})
      : _cepRepository = cepRepository;

  final CepRepository _cepRepository;
  CepModel? _cepModel;

  CepModel? get cepModel => _cepModel;

  // final CepRepository _cepRepository = getIt();

  Future<void> zipCodeSearch(String? cep) async {
    String cep2 ='';
    if (cep != null){
      String cepClean = cep.replaceAll("-", '').replaceAll(".", "");
      cep2 = cepClean;

    }
    
    try {
      if (cep != null) {
        _cepModel = await _cepRepository.getCep(cep2);

        if (_cepModel != null) {
          log('CEP: ${_cepModel?.logradouro}');
          notifyListeners();
        }
      }
    } catch (e, s) {
      // Tratar erros aqui
      log('Erro ao buscar CEP: $e $s');
    }
  }
}
