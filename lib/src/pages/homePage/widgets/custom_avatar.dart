import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/constants/app_router.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/services/firebase/auth_service_firebase_impl.dart';
import '../../../core/theme/seven_manager_theme.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthServiceFirebaseImpl authController = getIt();

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            authController.signOut();
            Navigator.of(context).pushReplacementNamed(AppRouter.login);
          },
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: SevenManagerTheme.tealBlue,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 120,
                width: 120,
                child: Image.network(
                  'https://files.adventistas.org/noticias/pt/2014/09/cartc3a3o-musica-grafica-848x478.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                'Desbravadores',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: SevenManagerTheme.tealBlue,
                ),
              )
            ],
          ),
        ));
  }
}
