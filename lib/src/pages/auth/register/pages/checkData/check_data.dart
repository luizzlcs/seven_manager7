import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/pages/auth/register/pages/checkData/widgets/fields_widgets.dart';
import 'package:seven_manager/src/pages/auth/register/pages/checkData/widgets/title_widget.dart';
import 'package:seven_manager/src/pages/auth/register/register_controller.dart';
import '../../../../../core/theme/seven_manager_theme.dart';

class CheckData extends StatefulWidget {
  const CheckData({super.key});

  @override
  State<CheckData> createState() => _CheckDataState();
}

class _CheckDataState extends State<CheckData>
    with AutomaticKeepAliveClientMixin {
  final RegisterController controller = getIt();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
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
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '4. Conferindo os dados',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: SevenManagerTheme.tealBlue,
                                fontSize: 26,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const TitleWidget(name: 'SOBRE SEU ACESSO'),
                          FieldsWidgets(
                              field:
                                  'Nome: ${controller.dataAcountPage['userName']}'),
                          FieldsWidgets(
                              field:
                                  'Email: ${controller.dataAcountPage['userEmail']}'),
                          FieldsWidgets(
                              field:
                                  'Senha: ${controller.dataAcountPage['userPassword']}'),
                          const SizedBox(height: 20),
                          const TitleWidget(name: 'SOBRE VOCÊ'),
                          FieldsWidgets(field: 'Sexo: ${controller.sexOption}'),
                          FieldsWidgets(
                              field:
                                  'CPF: ${controller.dataAboutYouPage['cpf']}'),
                          FieldsWidgets(
                              field:
                                  'Data de nascimento: ${controller.dataAboutYouPage['birth']}'),
                          FieldsWidgets(
                              field:
                                  'WhastApp: ${controller.dataAboutYouPage['whastAppPerson']}'),
                          FieldsWidgets(
                              field:
                                  'Cep: ${controller.dataAboutYouPage['zipCodePerson']}'),
                          FieldsWidgets(
                              field:
                                  'WhastApp: ${controller.dataAboutYouPage['whastAppPerson']}'),
                          FieldsWidgets(
                              field:
                                  'Logradouro: ${controller.dataAboutYouPage['streetPerson']}'),
                          FieldsWidgets(
                              field:
                                  'Número: ${controller.dataAboutYouPage['numberPerson']}'),
                          FieldsWidgets(
                              field:
                                  'Complemento: ${controller.dataAboutYouPage['complementPerson']}'),
                          FieldsWidgets(
                              field:
                                  'Cidade: ${controller.dataAboutYouPage['cityPerson']}'),
                          FieldsWidgets(
                              field:
                                  'Estado: ${controller.dataAboutYouPage['statePerson']}'),
                          FieldsWidgets(
                              field:
                                  'Receber Lic. Escola Sabatina: ${controller.confirmAddress ? 'Sim' : 'Não'}'),
                          const SizedBox(height: 35),
                          const TitleWidget(name: 'SOBRE SUA IGREJA'),
                          FieldsWidgets(
                              field:
                                  'Cep: ${controller.dataChurchPage['zipCodeChuchs']}'),
                          FieldsWidgets(
                              field:
                                  'Logradouro: ${controller.dataChurchPage['streetChuchs']}'),
                          FieldsWidgets(
                              field:
                                  'Bairo: ${controller.dataChurchPage['districtChuchs']}'),
                          FieldsWidgets(
                              field:
                                  'Cidade: ${controller.dataChurchPage['cityChuchs']}'),
                          FieldsWidgets(
                              field:
                                  'Estado: ${controller.dataChurchPage['stateChuchs']}'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
