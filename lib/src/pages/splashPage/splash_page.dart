import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';

Widget preview() {
  return const SplashPage();
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(seconds: 1),
        () => Navigator.of(context).pushReplacementNamed(AppRouter.login),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo_seven_manager.png'),
        ),
      ),
    );
  }
}
