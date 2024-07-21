import 'package:flutter/material.dart';
import 'package:seven_manager/seven_manager.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
void main() {
  configureDependencies();
  runApp(const SevenManager());
}


