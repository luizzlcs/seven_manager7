import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:seven_manager/src/core/services/dio_http_client.dart';
import 'package:seven_manager/src/core/services/firebase/firebase_storage_service.dart';
import 'package:seven_manager/src/core/widgets/imageAvatar/image_profile_controller.dart';
import 'package:seven_manager/src/interfaces/http_client.dart';
import 'package:seven_manager/src/model/cep_model.dart';
import 'package:seven_manager/src/pages/auth/login/login_controller.dart';
import 'package:seven_manager/src/pages/auth/recoverPassword/recover_controller.dart';
import 'package:seven_manager/src/pages/auth/register/pages/aboutYouPage/cep_controller_you.dart';
import 'package:seven_manager/src/pages/auth/register/pages/aboutYouchurchPage/cep_controller_you_church.dart';
import 'package:seven_manager/src/pages/auth/register/register_controller.dart';
import 'package:seven_manager/src/repositories/cep_repository.dart';
import '../services/firebase/auth_service_firebase_impl.dart';

final getIt = GetIt.I;

void configureDependencies() {
  log('Inicio da configuração de dependência');

  // Firebase
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<AuthServiceFirebaseImpl>(() => AuthServiceFirebaseImpl(auth: getIt<FirebaseAuth>()));

  // Controllers
  getIt.registerLazySingleton<RecoverController>(() => RecoverController(firebaseAuth: getIt<AuthServiceFirebaseImpl>()));
  getIt.registerLazySingleton<RegisterController>(() => RegisterController(firebaseAuth: getIt<AuthServiceFirebaseImpl>()));
  getIt.registerLazySingleton<LoginController>(() => LoginController(firebaseAuth: getIt<AuthServiceFirebaseImpl>()));
  getIt.registerLazySingleton<ImageProfileController>(() => ImageProfileController(storage: getIt<FirebaseStorageService>()));
  getIt.registerLazySingleton<CepControllerYou>(() => CepControllerYou(cepRepository: getIt<CepRepository>()));
  getIt.registerLazySingleton<CepControllerYouChurch>(() => CepControllerYouChurch(cepRepository: getIt<CepRepository>()));

  // Services
  getIt.registerLazySingleton<FirebaseStorageService>(() => FirebaseStorageService());
  getIt.registerLazySingleton<CepRepository>(() => CepRepository(httpClient: getIt<IHttpClient>()));

  // HTTP
  getIt.registerLazySingleton<Dio>(()=> Dio());
  getIt.registerLazySingleton<IHttpClient>(() => DioHttpClient(dio: getIt<Dio>()));
  
  log('Fim da configuração de dependência');
}

