import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:seven_manager/src/core/services/firebase/firebase_storage_service.dart';
import 'package:seven_manager/src/core/widgets/imageAvatar/image_profile_controller.dart';
import 'package:seven_manager/src/pages/auth/login/login_controller.dart';
import 'package:seven_manager/src/pages/auth/recoverPassword/recover_controller.dart';
import 'package:seven_manager/src/pages/auth/register/register_controller.dart';
import '../services/firebase/auth_service_firebase_impl.dart';

final getIt = GetIt.I;

void configureDependencies() {
  log('Inicio da configuração de dependência');

  getIt.registerFactory(() => FirebaseAuth.instance);
  getIt.registerFactory(() => AuthServiceFirebaseImpl(auth: getIt<FirebaseAuth>()));
  getIt.registerFactory(() => FirebaseStorageService());
  getIt.registerFactory(() => RecoverController(firebaseAuth: getIt<AuthServiceFirebaseImpl>()));
  getIt.registerFactory(() => RegisterController(firebaseAuth: getIt<AuthServiceFirebaseImpl>()));
  getIt.registerFactory(() => LoginController(firebaseAuth: getIt<AuthServiceFirebaseImpl>()));
  getIt.registerFactory(() => ImageProfileController(storage: getIt<FirebaseStorageService>()));

  log('Fim da configuração de dependência');
}
