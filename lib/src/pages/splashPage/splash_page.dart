import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_images.dart';
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
        () => Navigator.of(context).pushReplacementNamed(AppRouter.routerPage),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ((sizeOf.width) - (sizeOf.width * 0.8)) / 2,
            vertical: 10,
          ),
          child: const Image(
            image: AssetImage(AppImages.logoApp),
          ),
        ),
      ),
    );
  }
}
