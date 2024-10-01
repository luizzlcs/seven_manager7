import 'dart:developer';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seven_manager/firebase_options.dart';
import 'package:seven_manager/seven_manager.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:url_strategy/url_strategy.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  checkPlataform();

  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
  );

  configureDependencies();
  runApp(const SevenManager());
}

void checkPlataform() {
  if (kIsWeb) {
    log('Executando na WEB');
    setPathUrlStrategy();
  } else {
    log('Executando no Mobile ou Desktop');
  }
}
