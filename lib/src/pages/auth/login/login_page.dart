import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_images.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';
import 'package:seven_manager/src/core/widgets/helpers/seven_loader.dart';
import 'package:seven_manager/src/pages/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/injection/injection.dart';
import '../../../core/widgets/helpers/messages.dart';
import 'widgets/image_logo_widget.dart';
import '../../../core/widgets/helpers/loader.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Loader {
  final LoginController loginController = getIt();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEC = TextEditingController();
  final TextEditingController _passwordEC = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    loginController.addListener(_loginStatusChange);
    super.initState();
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    loginController.removeListener(_loginStatusChange);

    super.dispose();
  }

  void _loginStatusChange() {
    switch (loginController.loginStatus) {
      case LoginStatus.initial:
        break;
      case LoginStatus.loading:
        break;
      case LoginStatus.success:
        Messages.showSuccess(loginController.message, context);
        Navigator.of(context).pushNamed(AppRouter.homePage);
        break;
      case LoginStatus.error:
        Messages.showError(loginController.message, context);
    }
  }

  Future<void> _formSubmit() async {
    final valid = _formKey.currentState?.validate() ?? false;

    if (valid) {
      loginController.login(
        _emailEC.text,
        _passwordEC.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            Image.asset(
                              AppImages.logoGApp,
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(height: 32),
                            TextFormField(
                              controller: _emailEC,
                              focusNode: _emailFocus,
                              onFieldSubmitted: (_) async {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocus);
                              },
                              textInputAction: TextInputAction.next,
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
                                  controller: _passwordEC,
                                  focusNode: _passwordFocus,
                                  textInputAction: TextInputAction.next,
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
                                          ? const Icon(
                                              Icons.visibility_outlined)
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    (loginController.loginStatus ==
                                            LoginStatus.loading)
                                        ? const SevenLoader()
                                        : ElevatedButton(
                                            onPressed: () {
                                              _formSubmit();
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
            ),
          ],
        )),
      ),
    );
  }
}
