
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seven_manager/src/pages/auth/login/login_page.dart';
import 'package:seven_manager/src/pages/homePage/home_page.dart';

class RouterPage extends StatelessWidget {

  const RouterPage({ super.key });

   @override
   Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}