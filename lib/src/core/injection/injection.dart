

import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:seven_manager/src/pages/auth/login/login_controller.dart';

import '../services/firebase/firebase_auth_service.dart';

final getIt = GetIt.I;


void configureDependencies(){
  log('Inicio da configuração de dependência');
    getIt.registerFactory(() => FirebaseAuthService());
    getIt.registerFactory(() => LoginController(firebaseAuth: getIt<FirebaseAuthService>()));

  log('Fim da configuração de dependência');

}