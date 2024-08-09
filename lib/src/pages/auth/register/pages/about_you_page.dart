import 'dart:developer';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/constants/app_router.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/theme/seven_manager_theme.dart';
import '../../../../core/widgets/helpers/messages.dart';
import '../../../../core/widgets/helpers/seven_loader.dart';
import '../register_controller.dart';

class AboutYouPage extends StatefulWidget {
  const AboutYouPage({super.key});

  @override
  State<AboutYouPage> createState() => _AboutYouPageState();
}

class _AboutYouPageState extends State<AboutYouPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController namePersonEC = TextEditingController();
  final TextEditingController emailPersonEC = TextEditingController();
  final TextEditingController dateOfBirthPersonEC = TextEditingController();
  final TextEditingController cpfEC = TextEditingController();
  final TextEditingController malePersonEC = TextEditingController();
  final TextEditingController whastAppPersonEC = TextEditingController();
  final TextEditingController numberPersonEC = TextEditingController();
  final TextEditingController cityPersonEC = TextEditingController();
  final TextEditingController zipCodePersonEC = TextEditingController();
  final TextEditingController statePersonEC = TextEditingController();
  final TextEditingController streetPersonEC = TextEditingController();
  final TextEditingController isPostalServicePersonEC = TextEditingController();
  final TextEditingController complementPersonEC = TextEditingController();

  String _selectedOption = 'Masculino';
  bool _confirmAddress = false;

  final RegisterController registerController = getIt();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {}

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
      registerController.createPerson(
        namePerson: namePersonEC.text,
        dateOfBirthPerson: dateOfBirthPersonEC.text,
        cpf: cpfEC.text,
        malePerson: malePersonEC.text,
        whastAppPerson: whastAppPersonEC.text,
        numberPerson: numberPersonEC.text,
        cityPerson: cityPersonEC.text,
        zipCodePerson: zipCodePersonEC.text,
        statePerson: statePersonEC.text,
        streetPerson: streetPersonEC.text,
      );
    }
  }

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
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '2. Sobre você',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: SevenManagerTheme.tealBlue,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          RadioMenuButton<String>(
                            value: 'Masculino',
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value!;
                                print(_selectedOption);
                              });
                            },
                            child: const Text('Masculino'),
                          ),
                          RadioMenuButton<String>(
                            value: 'Feminino',
                            groupValue: _selectedOption,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedOption = value!;
                                print(_selectedOption);
                              });
                            },
                            child: const Text('Feminino'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: cpfEC,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        validator: Validatorless.multiple([
                          Validatorless.required('O CPF é obrigatório'),
                          Validatorless.cpf('O CPF digitado não é válido')
                        ]),
                        decoration: const InputDecoration(
                          label: Text('CPF'),
                          prefixIcon: Icon(
                            Icons.text_snippet,
                            color: SevenManagerTheme.tealBlue,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailPersonEC,
                        keyboardType: TextInputType.datetime,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter()
                        ],
                        validator: Validatorless.multiple([
                          Validatorless.required('Preenchimento obrigatório'),
                          Validatorless.date('Data inválida'),
                        ]),
                        decoration: const InputDecoration(
                          label: Text('Data de nascimento'),
                          hintText: 'Data de nascimento Ex.: 22/04/2010',
                          prefixIcon: Icon(
                            Icons.calendar_month,
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
                            controller: whastAppPersonEC,
                            keyboardType: TextInputType.phone,
                            validator:
                                Validatorless.required('Campo obrigatório'),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                            decoration: const InputDecoration(
                              label: Text('WhatsApp'),
                              hintText: 'Celular ou WhatsApp Ex. 84 98836-9729',
                              prefixIcon: Icon(
                                Icons.call,
                                color: SevenManagerTheme.tealBlue,
                                size: 28,
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
                            controller: zipCodePersonEC,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text('Cep'),
                              prefixIcon: Icon(
                                Icons.pin,
                                color: SevenManagerTheme.tealBlue,
                                size: 28,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: streetPersonEC,
                        decoration: const InputDecoration(
                          label: Text('Logradouro'),
                          hintText: 'Rua, aveninda, travessa...',
                          prefixIcon: Icon(
                            Icons.map,
                            color: SevenManagerTheme.tealBlue,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Flex(direction: Axis.horizontal, children: [
                        Flexible(
                          child: TextFormField(
                            controller: numberPersonEC,
                            decoration: const InputDecoration(
                              label: Text('Número'),
                              hintText: 'Rua, aveninda, travessa...',
                              prefixIcon: Icon(
                                Icons.looks_3,
                                color: SevenManagerTheme.tealBlue,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: TextFormField(
                            controller: complementPersonEC,
                            decoration: const InputDecoration(
                              label: Text('Complemento'),
                              prefixIcon: Icon(
                                Icons.info,
                                color: SevenManagerTheme.tealBlue,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 20),
                      Flex(direction: Axis.horizontal, children: [
                        Flexible(
                          child: TextFormField(
                            controller: cityPersonEC,
                            decoration: const InputDecoration(
                              label: Text('Cidade'),
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: SevenManagerTheme.tealBlue,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: TextFormField(
                            controller: statePersonEC,
                            decoration: const InputDecoration(
                              label: Text('Estado'),
                              prefixIcon: Icon(
                                Icons.star_rate,
                                color: SevenManagerTheme.tealBlue,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: SevenManagerTheme.lightCyan,
                          border: Border(
                              top: BorderSide(
                            color: SevenManagerTheme.tealBlue,
                          )),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Checkbox(
                                  semanticLabel: 'Confirmar',
                                  value: _confirmAddress,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _confirmAddress = value!;
                                      print(_confirmAddress);
                                    });
                                  }),
                            ),
                            const SizedBox(width: 10),
                            const Flexible(
                              flex: 2,
                              child:
                                  Text('Receber assinaturas da Lição da Escola'
                                      'Sabatina neste endereço.'),
                            ),
                          ],
                        ),
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
                                  : ElevatedButton.icon(
                                      onPressed: () {
                                        log('${registerController.dataAcountPage}');
                                      },
                                      label: const Text('Avançar'),
                                      icon: const Icon(Icons.account_circle),
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
