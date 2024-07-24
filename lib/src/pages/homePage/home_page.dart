import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';
import 'package:seven_manager/src/core/services/firebase/firebase_auth_service.dart';

class HomePage extends StatelessWidget {

  const HomePage({ super.key });

   @override
   Widget build(BuildContext context) {
   FirebaseAuthService auth = FirebaseAuthService();
       return Scaffold(
           appBar: AppBar(title: const Text('Home Page'),),
           body: Center(
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  child: IconButton(onPressed: (){
                    auth.signOut();
                    Navigator.of(context).pushReplacementNamed(AppRouter.login);
                  }, icon: const Icon(Icons.logout)),
                )
              ],
             ),
           ),
       );
  }
}