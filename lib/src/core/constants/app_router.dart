import 'package:flutter/material.dart';
import 'package:seven_manager/src/pages/auth/login/login_page.dart';
import 'package:seven_manager/src/pages/homePage/home_page.dart';
import 'package:seven_manager/src/pages/splashPage/splash_page.dart';

import '../../pages/auth/recoverPassword/recover_password_page.dart';
import '../../pages/auth/register/register_page.dart';

///Esta classe foi configurada para construir todas as rotas do aplicativo.
///
///Então no `[MaterialApp]` no parâmetro `[routes]` chame por `[AppRoutes.router]`.
///
/// ```dart
/// Widget build(BuildContext context) {
///    return MaterialApp(
///      routes: AppRouter.router,
///    );
/// }
/// ```
/// 
/// Para facilitar a utilização dos paparâmetros nomeados das rotas você pode
/// chamar as constantes que estão dentro da classe `[AppRouter.login]` ou simplesmente
/// passar a rota nomeada `['\login']`.
/// 
/// ```dart
/// Navigator.of(context).pushNamed(AppRouter.login)
////*  Ou ainda assim: */
/// Navigator.of(context).pushNamed('/login') 
/// 
/// ```
abstract class AppRouter {
  static Map<String, WidgetBuilder> get router {
    return {
      '/': (BuildContext context) => const SplashPage(),
      login: (BuildContext context) => const LoginPage(),
      register: (BuildContext context) => const RegisterPage(),
      recover: (BuildContext context) => const RecoverPasswordPage(),
      homePage: (BuildContext context) => const HomePage(),
    };
  }

  static const login = '/login';
  static const register = '/register';
  static const recover = '/recover';
  static const homePage = '/home-page';
}
