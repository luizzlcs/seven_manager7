import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';
import 'package:seven_manager/src/core/widgets/helpers/debounce.dart';
import 'package:seven_manager/src/core/widgets/helpers/loader.dart';
import 'package:seven_manager/src/core/widgets/helpers/messages.dart';
import 'package:seven_manager/src/core/widgets/imageAvatar/image_profile_controller.dart';
import 'package:seven_manager/src/pages/auth/register/pages/aboutYouchurchPage/about_you_church_page.dart';
import 'package:seven_manager/src/pages/auth/register/pages/aboutYouPage/about_you_page.dart';
import 'package:seven_manager/src/pages/auth/register/pages/createAccountPage/create_account_page.dart';
import 'package:seven_manager/src/pages/auth/register/pages/widgets/button_widget.dart';
import 'package:seven_manager/src/pages/auth/register/register_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/widgets/helpers/custom_dialog.dart';
import 'pages/checkData/check_data.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with Loader {
  ImageProfileController imageProfileController = getIt();
  @override
  void initState() {
    registerController.addListener(_switchController);
    super.initState();
  }

  final _controller = PageController();
  int _currentPage = 0;
  final debounce = Debounce();

  final RegisterController registerController = getIt();

  Future<void> _handleNextPage(
      {required Function submitForm, required int nextPage}) async {
    bool valid = submitForm();
    log('FORMULÁRIO VALÍDO: PÁGINA $nextPage $valid');
    if (valid) {
      registerController.setCheckValid();

      registerController.resetCheckValid();

      _currentPage = nextPage;
      _controller.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInCirc,
      );
    } else {
      Messages.showError('Ops! Alguma coisa de errado não deu certo', context);
    }
  }

  void accountNextPage() {
    log('SAINDO DA ACCOUNT PAGE');
    _handleNextPage(
        submitForm: registerController.submitFormAcount, nextPage: 1);
  }

  void youNextPage() {
    _handleNextPage(submitForm: registerController.submitFormYou, nextPage: 2);
  }

  void churchNextPage() {
    log('SAINDO DA CHURCH PAGE');
    _handleNextPage(
        submitForm: registerController.submitFormChurch, nextPage: 3);
  }

  void previewPage() {
    _currentPage = _currentPage - 1;
    _controller.previousPage(
        duration: const Duration(milliseconds: 600), curve: Curves.slowMiddle);
  }

  void _switchController() {
    switch (registerController.registerStatus) {
      case RegisterStatus.initial:
        log('INITIAL: ${registerController.message}');
        break;
      case RegisterStatus.loading:
        showLoader();
        log('LOADER: ${registerController.message}');
        break;
      case RegisterStatus.success:
        hideLoader();
        Messages.showSuccess(registerController.message, context);
        log('SUCCESS: ${registerController.message}');
        Navigator.of(context).pushReplacementNamed(AppRouter.login);
        break;
      case RegisterStatus.error:
        hideLoader();
        Messages.showError(registerController.message, context);

        log('ERROR: ${registerController.message}');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        showPresentDialog(
          context: context,
          title: 'CANCELAR',
          content: 'Tem certeza que deseja cancelar este cadastro?',
          icon: Icons.how_to_reg,
          onConfirm: () {
            Navigator.pushReplacementNamed(context, AppRouter.login);
            imageProfileController.clearImageUrlFile();
            log('DELETANDO IMAGE: ${imageProfileController.urlImage}');
          },
        );
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Criar conta'),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: SevenManagerTheme.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: PageView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _controller,
                                children: const [
                                  CreateAccountPage(),
                                  AboutYouPage(),
                                  AboutYouChurchPage(),
                                  CheckData(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: (_currentPage >= 1),
                                child: ButtonWidget(
                                  name: 'VOLTAR',
                                  alignment: IconAlignment.start,
                                  icon: Icons.arrow_back_ios,
                                  function: () {
                                    setState(() {});
                                    previewPage();
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Visibility(
                                visible: (_currentPage >= 0 && _currentPage < 3),
                                child: ButtonWidget(
                                  name: 'AVANÇAR',
                                  alignment: IconAlignment.end,
                                  icon: Icons.arrow_forward_ios_outlined,
                                  function: () {
                                    setState(() {});
                                    switch (_currentPage) {
                                      case 0:
                                        accountNextPage();
                                        break;
                                      case 1:
                                        youNextPage();
                                      case 2:
                                        churchNextPage();
                                        break;
                                    }
                                  },
                                ),
                              ),
                              Visibility(
                                visible: _currentPage == 3,
                                child: ButtonWidget(
                                  name: 'CONCLUIR',
                                  alignment: IconAlignment.start,
                                  icon: Icons.folder_open_sharp,
                                  function: () async {
                                    await registerController.createUser();
                                    if (imageProfileController.urlImage != null) {
                                      if (imageProfileController.imageFile !=
                                          null) {
                                        imageProfileController.clearUrl();
                                        imageProfileController.clearFile();
                                      }
                                    }                                   
                                  },
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          SmoothPageIndicator(
                            controller: _controller,
                            count: 4,
                            effect: const ExpandingDotsEffect(
                              activeDotColor: SevenManagerTheme.tealBlue,
                              dotColor: Color.fromARGB(255, 117, 188, 230),
                              dotHeight: 16,
                              dotWidth: 16,
                              spacing: 12,
                              //verticalOffset: 50,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
