import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:seven_manager/src/core/constants/app_images.dart';
import 'package:seven_manager/src/core/widgets/helpers/messages.dart';
import 'package:seven_manager/src/pages/auth/register/pages/aboutYouPage/about_you_page_mixin.dart';
import 'package:validatorless/validatorless.dart';
import '../../../../../core/theme/seven_manager_theme.dart';

class AboutYouPage extends StatefulWidget {
  const AboutYouPage({super.key});

  @override
  State<AboutYouPage> createState() => _AboutYouPageState();
}

class _AboutYouPageState extends State<AboutYouPage>
    with AutomaticKeepAliveClientMixin, AboutYouPageMixin {
  @override
  bool get wantKeepAlive => true;

  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preenchimento obrigatório';
    }
    try {
      DateFormat('dd/MM/yyyy').parseStrict(value);
    } catch (e) {
      return 'Data inválida';
    }
    return null;
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
                  key: registerController.formKeyYou,
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
                      AnimatedBuilder(
                        animation: registerController,
                        builder: (context, child) {
                          return Row(
                            children: [
                              RadioMenuButton<String>(
                                focusNode: malePersonFocus,
                                value: 'Masculino',
                                groupValue: registerController.sexOption,
                                onChanged: (String? value) {
                                  registerController.changeSexOptions(value!);
                                },
                                child: const Text('Masculino'),
                              ),
                              RadioMenuButton<String>(
                                value: 'Feminino',
                                groupValue: registerController.sexOption,
                                onChanged: (String? value) {
                                  registerController.changeSexOptions(value!);
                                },
                                child: const Text('Feminino'),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: cpfEC,
                        focusNode: cpfFocus,
                        onFieldSubmitted: (_) async {
                          FocusScope.of(context).requestFocus(birthFocus);
                        },
                        textInputAction: TextInputAction.next,
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
                        controller: birthEC,
                        focusNode: birthFocus,
                        onFieldSubmitted: (_) async {
                          FocusScope.of(context)
                              .requestFocus(whastAppPersonFocus);
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.datetime,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter()
                        ],
                        validator: validateDate,
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
                            focusNode: whastAppPersonFocus,
                            onFieldSubmitted: (_) async {
                              FocusScope.of(context)
                                  .requestFocus(zipCodePersonFocus);
                            },
                            textInputAction: TextInputAction.next,
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
                            focusNode: zipCodePersonFocus,
                            onFieldSubmitted: (_) async {
                              FocusScope.of(context)
                                  .requestFocus(streetPersonFocus);
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter()
                            ],
                            decoration: InputDecoration(
                              label: const Text('Cep'),
                              prefixIcon: const Icon(
                                Icons.pin,
                                color: SevenManagerTheme.tealBlue,
                                size: 28,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  cepController
                                      .zipCodeSearch(zipCodePersonEC.text)
                                      .then((_) {
                                    if (cepController.cepModel != null) {
                                      streetPersonEC.text =
                                          cepController.cepModel!.logradouro;
                                          districtPersonEC.text =
                                          cepController.cepModel!.bairro;
                                      cityPersonEC.text =
                                          cepController.cepModel!.localidade;
                                      statePersonEC.text =
                                          cepController.cepModel!.uf;
                                    } else {
                                      Messages.showInfo(
                                          'O CEP: ${zipCodePersonEC.text} não foi encontrado',
                                          context);
                                      streetPersonEC.text =
                                          'CEP não encontrado';
                                    }
                                  });
                                },
                                style: IconButton.styleFrom(
                                    backgroundColor: SevenManagerTheme.tealBlue,
                                    side: const BorderSide(
                                        color: Colors
                                            .transparent), // Remove border for a flat look
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                    )),
                                color: Colors.red,
                                icon: Image.asset(
                                  AppImages.correiosLogo,
                                  width: 25,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: streetPersonEC,
                        focusNode: streetPersonFocus,
                        onFieldSubmitted: (_) async {
                          FocusScope.of(context)
                              .requestFocus(districtPersonFocus);
                        },
                        textInputAction: TextInputAction.next,
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
                       TextFormField(
                        controller: districtPersonEC,
                        focusNode: districtPersonFocus,
                        onFieldSubmitted: (_) async {
                          FocusScope.of(context)
                              .requestFocus(numberPersonFocus);
                        },
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          label: Text('Bairro'),
                          prefixIcon: Icon(
                            Icons.account_balance,
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
                            focusNode: numberPersonFocus,
                            onFieldSubmitted: (_) async {
                              FocusScope.of(context)
                                  .requestFocus(complementPersonFocus);
                            },
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              label: Text('Número'),
                              hintText: '88',
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
                            focusNode: complementPersonFocus,
                            onFieldSubmitted: (_) async {
                              FocusScope.of(context)
                                  .requestFocus(cityPersonFocus);
                            },
                            textInputAction: TextInputAction.next,
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
                            focusNode: cityPersonFocus,
                            onFieldSubmitted: (_) async {
                              FocusScope.of(context)
                                  .requestFocus(statePersonFocus);
                            },
                            textInputAction: TextInputAction.next,
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
                            focusNode: statePersonFocus,
                            onFieldSubmitted: (_) async {
                              FocusScope.of(context)
                                  .requestFocus(confimAddresFocus);
                            },
                            textInputAction: TextInputAction.next,
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
                              child: Tooltip(
                                message: 'Receber encomendas',
                                child: AnimatedBuilder(
                                  animation: registerController,
                                  builder: (context, child) {
                                    return Checkbox(
                                      semanticLabel: 'Confirmar',
                                      value: registerController.confirmAddress,
                                      onChanged: (bool? value) {
                                        registerController
                                            .changeConfirmAddress();
                                      },
                                    );
                                  },
                                ),
                              ),
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
