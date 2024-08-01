import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_images.dart';
import 'package:seven_manager/src/pages/auth/login/widgets/image_logo_widget.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/constants/app_router.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/theme/seven_manager_theme.dart';
import '../../../../core/widgets/helpers/messages.dart';
import '../register_controller.dart';

class AboutYouChurchPage extends StatefulWidget {
  const AboutYouChurchPage({super.key});

  @override
  State<AboutYouChurchPage> createState() => _AboutYouChurchPageState();
}

class _AboutYouChurchPageState extends State<AboutYouChurchPage> {
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
                    children: [
                      const SizedBox(height: 10),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '3. Sobre sua Igreja',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: SevenManagerTheme.tealBlue,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      const ImageLogoWidget(pathImage: AppImages.logoIasd),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: nameEC,
                        validator: Validatorless.required(
                            'O nome do usuário é necessário'),
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                          prefixIcon: Icon(
                            Icons.person,
                            color: SevenManagerTheme.tealBlue,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
