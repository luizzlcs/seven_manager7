import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/services/firebase/auth_service_firebase_impl.dart';

class HomePage extends StatelessWidget {

  const HomePage({ super.key });

   @override
   Widget build(BuildContext context) {
   AuthServiceFirebaseImpl auth = getIt();
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