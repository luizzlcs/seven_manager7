import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';

class SevenManager extends StatelessWidget {
  const SevenManager({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: SevenManagerTheme.lightTheme,
      routes: AppRouter.router,
    );
  }
}
