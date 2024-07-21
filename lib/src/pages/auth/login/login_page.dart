import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_images.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';
import 'package:seven_manager/src/pages/auth/login/login_controller.dart';

import 'widgets/image_logo_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = LoginController();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: ImageLogoWidget(
              pathImage: AppImages.logoIasd,
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Container(
                height: sizeOf.height,
                width: sizeOf.width,
                decoration: const BoxDecoration(
                    color: SevenManagerTheme.whiteColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Image.asset(AppImages.logoGApp),
                      const SizedBox(height: 20),
                      const SizedBox(height: 32),
                      TextFormField(
                        style:
                            const TextStyle(color: SevenManagerTheme.tealBlue),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            size: 28,
                          ),
                          label: Text('E-mail'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        obscureText: !isVisible,
                        style: const TextStyle(
                          color: SevenManagerTheme.tealBlue,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.key_outlined,
                            size: 28,
                          ),
                          suffixIcon: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return IconButton(
                                onPressed: () {
                                  _controller.changeVisible();
                                  setState(() {
                                    isVisible = _controller.isVisible;
                                  });
                                },
                                icon: isVisible
                                    ? const Icon(Icons.visibility_outlined)
                                    : const Icon(Icons.visibility_off_outlined),
                              );
                            },
                          ),
                          label: const Text('Senha'),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print('Tela de login');
                            },
                            child: const Text('ENTRAR'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed(AppRouter.recover),
                        child: const Text(
                          'Esqueci minha senha',
                          // style: SincofarmaTheme.titleSmallBold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Não tem uma conta?',
                            // style: SincofarmaTheme.titleSmallRegular,
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed(AppRouter.register),
                            child: const Text(
                              'Cadastre-se?',
                              // style: SincofarmaTheme.titleSmallBold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
