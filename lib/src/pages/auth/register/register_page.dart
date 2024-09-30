import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';
import 'package:seven_manager/src/core/widgets/helpers/loader.dart';
import 'package:seven_manager/src/core/widgets/helpers/messages.dart';
import 'package:seven_manager/src/core/widgets/helpers/seven_loader.dart';
import 'package:seven_manager/src/pages/auth/register/pages/aboutYouchurchPage/image_profile_controller_church.dart';
import 'package:seven_manager/src/pages/auth/register/pages/aboutYouchurchPage/about_you_church_page.dart';
import 'package:seven_manager/src/pages/auth/register/pages/aboutYouPage/about_you_page.dart';
import 'package:seven_manager/src/pages/auth/register/pages/createAccountPage/create_account_page.dart';
import 'package:seven_manager/src/pages/auth/register/pages/createAccountPage/image_profile_controller_account.dart';
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
  ImageProfileControllerChurch imageLogoController = getIt();
  ImageProfileControllerAccount imageAvatarController = getIt();
  final RegisterController registerController = getIt();
  final _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  void navigateToLogin(BuildContext context) {
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRouter.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  showPresentDialog(
                    context: context,
                    title: 'CANCELAR',
                    content: 'Tem certeza que deseja cancelar este cadastro?',
                    icon: Icons.how_to_reg,
                    onConfirm: () {
                      Navigator.pushReplacementNamed(context, AppRouter.login);
                      imageLogoController.clearImageUrlFile();
                      imageAvatarController.clearImageUrlFile();
                      log('DELETANDO IMAGE: ${imageLogoController.urlImage}');
                    },
                  );
                },
                icon: const Icon(Icons.arrow_back)),
            const Text('Criar conta'),
          ],
        )),
        body: Align(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 480,
              minWidth: 250,
            ),
            child: Column(
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
                                  visible:
                                      (_currentPage >= 0 && _currentPage < 3),
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
                                AnimatedBuilder(
                                  animation: registerController,
                                  builder: (context, child) {
                                    return Visibility(
                                      visible: _currentPage == 3,
                                      child: Column(
                                        children: [
                                          registerController.registerStatus ==
                                                  RegisterStatus.loading
                                              ? const SevenLoader()
                                              : ButtonWidget(
                                                  name: 'CONCLUIR',
                                                  alignment: IconAlignment.start,
                                                  icon: Icons.folder_open_sharp,
                                                  function: () async {
                                                    await registerController
                                                        .createUser(context);
          
                                                    if (imageLogoController
                                                            .urlImage !=
                                                        null) {
                                                      if (imageLogoController
                                                              .imageFile !=
                                                          null) {
                                                        imageLogoController
                                                            .clearUrl();
                                                        imageLogoController
                                                            .clearFile();
                                                      }
                                                    }
                                                    if (imageAvatarController
                                                            .urlImage !=
                                                        null) {
                                                      if (imageAvatarController
                                                              .imageFile !=
                                                          null) {
                                                        imageAvatarController
                                                            .clearUrl();
                                                        imageAvatarController
                                                            .clearFile();
                                                      }
                                                    }
                                                  },
                                                ),
                                        ],
                                      ),
                                    );
                                  },
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
      ),
    );
  }
}
