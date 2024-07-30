import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';
import 'package:seven_manager/src/core/widgets/helpers/loader.dart';
import 'package:seven_manager/src/core/widgets/helpers/messages.dart';
import 'package:seven_manager/src/pages/auth/register/pages/about_you_church_page.dart';
import 'package:seven_manager/src/pages/auth/register/pages/about_you_page.dart';
import 'package:seven_manager/src/pages/auth/register/pages/create_account_page.dart';
import 'package:seven_manager/src/pages/auth/register/register_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with Loader {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameEC = TextEditingController();
  final TextEditingController emailEC = TextEditingController();
  final TextEditingController passwordEC = TextEditingController();
  final TextEditingController confirmePasswordEC = TextEditingController();

  final _controller = PageController();

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
    return Scaffold(
      appBar: AppBar(),
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 600,
                            color: SevenManagerTheme.whiteColor,
                            child: PageView(
                              controller: _controller,
                              children: const [
                                CreateAccountPage(),
                                AboutYouPage(),
                                AboutYouChurchPage(),
                              ],
                            ),
                          ),
                          const SizedBox(
                             height: 40,
                          ),
                          SmoothPageIndicator(
                            controller: _controller,
                            count: 3,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Colors.deepPurple,
                              dotColor: Colors.deepPurple.shade100,
                              dotHeight: 30,
                              dotWidth: 30,
                              spacing: 16,
                              //verticalOffset: 50,
                            ),
                          ),
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
