import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';
import 'package:seven_manager/src/core/widgets/helpers/messages.dart';
import 'package:seven_manager/src/core/widgets/helpers/seven_loader.dart';
import 'package:seven_manager/src/pages/auth/recoverPassword/recover_controller.dart';
import 'package:validatorless/validatorless.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  RecoverController recoverController = getIt();

  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();

  @override
  void initState() {
    recoverController.addListener(_statusRecoverChange);
    super.initState();
  }

  @override
  void dispose() {
    _emailEC.dispose();
    recoverController.removeListener(_statusRecoverChange);
    super.dispose();
  }

  void _statusRecoverChange() {
    switch (recoverController.recoverStatus) {
      case RecoverStatus.initial:
        break;
      case RecoverStatus.loading:
        break;
      case RecoverStatus.success:
        Navigator.of(context).pushNamed(AppRouter.login);
        Messages.showSuccess(recoverController.message, context);
        break;
      case RecoverStatus.error:
        Messages.showError(recoverController.message, context);
        break;
    }
  }

  void _formSubmit() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      recoverController.recoverEmail(_emailEC.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: SevenManagerTheme.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 30),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 90,
                          ),
                          BorderedText(
                            strokeColor: SevenManagerTheme.whiteColor,
                            strokeCap: StrokeCap.round,
                            child: const Text(
                              'RECUPERAR SENHA',
                              style: TextStyle(
                                fontSize: 30,
                                color: SevenManagerTheme.tealBlue,
                              ),
                            ),
                          ),
                          const SizedBox(height: 35),
                          const Icon(
                            Icons.lock_clock,
                            size: 150,
                            color: SevenManagerTheme.tealBlue,
                          ),
                          const SizedBox(height: 35),
                          const Text(
                            textAlign: TextAlign.center,
                            'Para recuperar sua senha, é necessário ter, ao menos,'
                            'o e-mail utilizado para o login.',
                            style: TextStyle(
                              fontSize: 16,
                              color: SevenManagerTheme.tealBlue,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: Validatorless.multiple([
                              Validatorless.required(
                                  'O e-mail digitado não é valido.'),
                              Validatorless.email(
                                  'O e-mail digitado não é valido.'),
                            ]),
                            controller: _emailEC,
                            decoration: const InputDecoration(
                              hintText: 'Digite seu email',
                            ),
                          ),
                          const SizedBox(height: 20),
                          AnimatedBuilder(
                            animation: recoverController,
                            builder: (context, child) {
                              
                              return Column(
                                children: [
                                  recoverController.recoverStatus ==
                                          RecoverStatus.loading
                                      ? const SevenLoader()
                                      : ElevatedButton(
                                          onPressed: () {
                                            _formSubmit();
                                            print(recoverController
                                                .recoverStatus);
                                          },
                                          child: const Text('Continuar'),
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
          ),
        ],
      ),
    );
  }
}
