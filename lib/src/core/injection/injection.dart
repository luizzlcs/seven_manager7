import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:seven_manager/src/core/widgets/imageAvatar/image_profile_controller.dart';
import 'package:seven_manager/src/pages/auth/login/login_controller.dart';
import 'package:seven_manager/src/pages/auth/recoverPassword/recover_controller.dart';
import 'package:seven_manager/src/pages/auth/register/register_controller.dart';
import '../services/firebase/firebase_auth_service.dart';

final getIt = GetIt.I;

void configureDependencies() {
  log('Inicio da configuração de dependência');

  getIt.registerFactory(() => FirebaseAuthService());
  getIt.registerFactory(() => RecoverController(firebaseAuth: getIt<FirebaseAuthService>()));
  getIt.registerFactory(() => RegisterController(firebaseAuth: getIt<FirebaseAuthService>()));
  getIt.registerFactory(() => LoginController(firebaseAuth: getIt<FirebaseAuthService>()));
  getIt.registerFactory(() => ImageProfileController());

  log('Fim da configuração de dependência');
}
