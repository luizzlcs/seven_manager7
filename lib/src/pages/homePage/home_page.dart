import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/pages/auth/login/login_controller.dart';
import 'package:seven_manager/src/pages/homePage/widgets/custom_avatar.dart';
import '../../core/theme/seven_manager_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

   
 

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = getIt();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            size: 30,
            color: SevenManagerTheme.whiteColor,
          ),
        ),
        backgroundColor: SevenManagerTheme.tealBlue,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
              size: 30,
              color: SevenManagerTheme.whiteColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              size: 30,
              color: SevenManagerTheme.whiteColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    loginController.message,
                    style: const TextStyle(
                        color: SevenManagerTheme.whiteColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 110,
                )
              ],
            ),
            Center(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 715,
                      width: double.infinity,
                      decoration: const ShapeDecoration(
                        color: SevenManagerTheme.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding:  EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                             CustomCircleAvatar(),
                             CustomCircleAvatar(),
                             CustomCircleAvatar(),
                             CustomCircleAvatar(),
                             CustomCircleAvatar(),
                             CustomCircleAvatar(),
                             CustomCircleAvatar(),
                             CustomCircleAvatar(),
                             CustomCircleAvatar(),
                             CustomCircleAvatar(),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  //  Widget build(BuildContext context) {
  //  AuthServiceFirebaseImpl auth = getIt();
  //      return Scaffold(
  //          appBar: AppBar(title: const Text('Home Page'),),
  //          body: Center(
  //            child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Container(
  //                 color: Colors.white,
  //                 child: IconButton(onPressed: (){
  //                   auth.signOut();
  //                   Navigator.of(context).pushReplacementNamed(AppRouter.login);
  //                 }, icon: const Icon(Icons.logout)),
  //               )
  //             ],
  //            ),
  //          ),
  //      );
  // }