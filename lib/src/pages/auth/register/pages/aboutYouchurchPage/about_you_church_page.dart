import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seven_manager/src/core/constants/app_images.dart';
import 'package:seven_manager/src/pages/auth/login/widgets/image_logo_widget.dart';
import 'package:seven_manager/src/pages/auth/register/pages/aboutYouchurchPage/about_you_church_page_mixin.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../../core/theme/seven_manager_theme.dart';

class AboutYouChurchPage extends StatefulWidget {
  const AboutYouChurchPage({super.key});

  @override
  State<AboutYouChurchPage> createState() => _AboutYouChurchPageState();
}

class _AboutYouChurchPageState extends State<AboutYouChurchPage>
    with AutomaticKeepAliveClientMixin, AboutYouChurchPageMixin {
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
                  key: registerController.formKeyChurch,
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
                        controller: zipCodeChuchsEC,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (_) async {
                          FocusScope.of(context)
                              .requestFocus(streetChurchsFocus);
                        },
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CepInputFormatter()
                        ],
                        validator: Validatorless.required('Digite o Cep'),
                        decoration: const InputDecoration(
                          label: Text('Cep'),
                          prefixIcon: Icon(
                            Icons.pin,
                            color: SevenManagerTheme.tealBlue,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: streetChuchsEC,
                        focusNode: streetChurchsFocus,
                        onFieldSubmitted: (_) async {
                          FocusScope.of(context)
                              .requestFocus(districtChurchsFocus);
                        },
                        textInputAction: TextInputAction.next,
                        validator: Validatorless.required('Logradouro'),
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
                        controller: districtChuchsEC,
                        focusNode: districtChurchsFocus,
                        onFieldSubmitted: (_) async {
                          FocusScope.of(context).requestFocus(cityChurchsFocus);
                        },
                        textInputAction: TextInputAction.next,
                        validator: Validatorless.required('Bairro da igreja'),
                        decoration: const InputDecoration(
                          label: Text('Bairro'),
                          prefixIcon: Icon(
                            Icons.maps_home_work,
                            color: SevenManagerTheme.tealBlue,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: cityChuchsEC,
                        validator: Validatorless.required('Cidade'),
                        focusNode: cityChurchsFocus,
                        onFieldSubmitted: (_) async {
                          FocusScope.of(context)
                              .requestFocus(stateChurchsFocus);
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
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: stateChuchsEC,
                        focusNode: stateChurchsFocus,
                        textInputAction: TextInputAction.done,
                        validator: Validatorless.required('Estado'),
                        decoration: const InputDecoration(
                          label: Text('Estado'),
                          prefixIcon: Icon(
                            Icons.star_rate,
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
