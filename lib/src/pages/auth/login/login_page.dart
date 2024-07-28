import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_images.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';
import 'package:seven_manager/src/pages/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/injection/injection.dart';
import 'widgets/image_logo_widget.dart';
import '../../../core/widgets/helpers/loader.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Loader{
  final LoginController loginController = getIt();

  @override
  void dispose() {
    loginController.emailEC.dispose();
    loginController.passwordEC.dispose();
    super.dispose();
  }

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
                child: Form(
                  key: loginController.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Image.asset(AppImages.logoGApp),
                        const SizedBox(height: 20),
                        const SizedBox(height: 32),
                        TextFormField(
                          controller: loginController.emailEC,
                          style: const TextStyle(
                              color: SevenManagerTheme.tealBlue),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              size: 28,
                            ),
                            label: Text('E-mail'),
                          ),
                          validator: Validatorless.multiple(
                            [
                              Validatorless.email(
                                  'O valor digitado não é um E-mail válido.'),
                              Validatorless.required(
                                  'Você ainda anão digitou um E-mail.')
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        AnimatedBuilder(
                          animation: loginController,
                          builder: (context, child) {
                            return TextFormField(
                              controller: loginController.passwordEC,
                              obscureText: !loginController.isVisible,
                              style: const TextStyle(
                                color: SevenManagerTheme.tealBlue,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.key_outlined,
                                  size: 28,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    loginController.changeVisible();
                                  },
                                  icon: loginController.isVisible
                                      ? const Icon(Icons.visibility_outlined)
                                      : const Icon(
                                          Icons.visibility_off_outlined),
                                ),
                                label: const Text('Senha'),
                              ),
                              validator: Validatorless.required(
                                  'Você ainda não digitou a senha.'),
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                        AnimatedBuilder(
                          animation: loginController,
                          builder: (context, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                (loginController.isLoading)
                                    ? const Text('Incrementar loader aqui.')
                                    : ElevatedButton(
                                        onPressed: () {
                                          loginController.login(context);
                                        },
                                        child: const Text('ENTRAR'),
                                      ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                        TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(AppRouter.recover),
                          child: const Text(
                            'Esqueci minha senha',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Não tem uma conta?',
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(AppRouter.register),
                              child: const Text(
                                'Cadastre-se?',
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
          ),
        ],
      )),
    );
  }
}
