import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:seven_manager/firebase_options.dart';
import 'package:seven_manager/seven_manager.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  configureDependencies();
  runApp(const SevenManager());
}


