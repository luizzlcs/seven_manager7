import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';
import 'package:seven_manager/src/core/widgets/helpers/loader.dart';
import 'package:seven_manager/src/pages/auth/register/pages/createAccountPage/create_account_page_mixin.dart';
import 'package:validatorless/validatorless.dart';
import '../../../../../core/widgets/imageAvatar/image_avatar_widget.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({
    super.key,
  });

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage>
    with Loader, AutomaticKeepAliveClientMixin, CreateAccountPageMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  key: registerController.formKeyAccount,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Align(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            textAlign: TextAlign.left,
                            'Olá, vamos fazer o seu cadastro!',
                            style: TextStyle(
                              color: SevenManagerTheme.tealBlue,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '1. Adicione seus dados',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: SevenManagerTheme.tealBlue,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ImageAvatarWidget(imageController: imageProfileController,),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: nameEC,
                        focusNode: nameFocus,
                        onFieldSubmitted: (_) async {
                          FocusScope.of(context).requestFocus(emailFocus);
                        },
                        textInputAction: TextInputAction.next,
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
                      TextFormField(
                        controller: emailEC,
                        focusNode: emailFocus,
                        onFieldSubmitted: (_) async {
                          FocusScope.of(context).requestFocus(passwordFocus);
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validatorless.multiple([
                          Validatorless.required(
                              'Digite o e-mail para o usuário'),
                          Validatorless.email('O e-mail digitado não é válido'),
                        ]),
                        decoration: const InputDecoration(
                          label: Text('E-mail'),
                          prefixIcon: Icon(
                            Icons.email,
                            color: SevenManagerTheme.tealBlue,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AnimatedBuilder(
                        animation: registerController,
                        builder: (context, child) {
                          return TextFormField(
                            obscureText: !registerController.isVisible,
                            controller: passwordEC,
                            focusNode: passwordFocus,                            
                            onFieldSubmitted: (_) async {
                              FocusScope.of(context)
                                  .requestFocus(confirmePasswordFocus);
                            },
                            textInputAction: TextInputAction.next,
                            validator: Validatorless.multiple([
                              Validatorless.required(
                                  'Você precisa digitar um senha'),
                              Validatorless.min(6,
                                  'A senha deve possuir no mínimo 6 caracteres')
                            ]),
                            decoration: InputDecoration(
                              label: const Text('Senha'),
                              prefixIcon: const Icon(
                                Icons.key,
                                color: SevenManagerTheme.tealBlue,
                                size: 28,
                              ),
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
                            focusNode: confirmePasswordFocus,
                            textInputAction: TextInputAction.done,
                            validator: Validatorless.multiple([
                              Validatorless.required(
                                  'Digite a senha de confirmação'),
                              Validatorless.compare(passwordEC,
                                  'As senhas digitadas não coincidem')
                            ]),
                            decoration: InputDecoration(
                              label: const Text('Confirmar senha'),
                              prefixIcon: const Icon(
                                Icons.key,
                                color: SevenManagerTheme.tealBlue,
                                size: 28,
                              ),
                              suffixIcon: registerController.passwordMatch
                                  ? const Icon(
                                      Icons.check_circle_sharp,
                                      color: SevenManagerTheme.mediumSeaGreen,
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
