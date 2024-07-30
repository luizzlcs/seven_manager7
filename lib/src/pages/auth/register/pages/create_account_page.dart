import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';
import 'package:seven_manager/src/core/widgets/helpers/loader.dart';
import 'package:seven_manager/src/core/widgets/helpers/messages.dart';
import 'package:seven_manager/src/pages/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/widgets/helpers/seven_loader.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> with Loader {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameEC = TextEditingController();
  final TextEditingController emailEC = TextEditingController();
  final TextEditingController passwordEC = TextEditingController();
  final TextEditingController confirmePasswordEC = TextEditingController();


  final RegisterController registerController = getIt();

  @override
  void initState() {
    confirmePasswordEC.addListener(() {
      registerController.checkPasswordsMatch(
          passwordEC.text, confirmePasswordEC.text);
    });
    passwordEC.addListener(() {
      registerController.checkPasswordsMatch(
          passwordEC.text, confirmePasswordEC.text);
    });

    registerController.addListener(_registerStatusChange);

    super.initState();
  }

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    confirmePasswordEC.dispose();
    registerController.removeListener(_registerStatusChange);
    super.dispose();
  }

  void _registerStatusChange() {
    switch (registerController.registerStatus) {
      case RegisterStatus.initial:
        break;
      case RegisterStatus.loading:
        break;
      case RegisterStatus.success:
        Navigator.of(context).pushNamed(AppRouter.homePage);
        Messages.showSuccess(registerController.message, context);
        break;
      case RegisterStatus.error:
        Messages.showError(registerController.message, context);
    }
  }

  Future<void> _formSubmit() async {
    final valid = formKey.currentState?.validate() ?? false;

    if (valid) {
      registerController.createUser(
        name: nameEC.text,
        email: emailEC.text,
        password: passwordEC.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: SevenManagerTheme.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: BorderedText(
                            strokeWidth: 9.0,
                            strokeColor: SevenManagerTheme.whiteColor,
                            child: const Text(
                              textAlign: TextAlign.center,
                              'CRIAR NOVO USUÁRIO',
                              style: TextStyle(
                                color: SevenManagerTheme.tealBlue,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        TextFormField(
                          controller: nameEC,
                          validator: Validatorless.required(
                              'O nome do usuário é necessário'),
                          decoration: const InputDecoration(
                            label: Text('Nome'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailEC,
                          validator: Validatorless.multiple([
                            Validatorless.required(
                                'Digite o e-mail para o usuário'),
                            Validatorless.email(
                                'O e-mail digitado não é válido'),
                          ]),
                          decoration: const InputDecoration(
                            label: Text('E-mail'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        AnimatedBuilder(
                          animation: registerController,
                          builder: (context, child) {
                            return TextFormField(
                              obscureText: !registerController.isVisible,
                              controller: passwordEC,
                              validator: Validatorless.multiple([
                                Validatorless.required(
                                    'Você precisa digitar um senha'),
                                Validatorless.min(6,
                                    'A senha deve possuir no mínimo 6 caracteres')
                              ]),
                              decoration: InputDecoration(
                                label: const Text('Senha'),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    registerController.changeVisible();
                                  },
                                  icon: registerController.isVisible
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        AnimatedBuilder(
                          animation: registerController,
                          builder: (context, child) {
                            return TextFormField(
                              obscureText: !registerController.isVisible,
                              controller: confirmePasswordEC,
                              validator: Validatorless.multiple([
                                Validatorless.required(
                                    'Digite a senha de confirmação'),
                                Validatorless.compare(passwordEC,
                                    'As senhas digitadas não coincidem')
                              ]),
                              decoration: InputDecoration(
                                label: const Text('Confirmar senha'),
                                suffixIcon: registerController.passwordMatch
                                    ? const Icon(
                                        Icons.check_circle_sharp,
                                        color:
                                            SevenManagerTheme.mediumSeaGreen,
                                        size: 20,
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          confirmePasswordEC.clear();
                                        },
                                        icon: const Icon(
                                          Icons.do_not_disturb_on,
                                          color: SevenManagerTheme.redOrange,
                                          size: 20,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        AnimatedBuilder(
                          animation: registerController,
                          builder: (context, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                registerController.registerStatus ==
                                        RegisterStatus.loading
                                    ? const SevenLoader()
                                    : ElevatedButton(
                                        onPressed: () {
                                          _formSubmit();
                                        },
                                        child: const Text('Criar usuário'),
                                      )
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    
  }
}
