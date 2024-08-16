import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
        color: SevenManagerTheme.lightCyan,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            name,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: SevenManagerTheme.tealBlue,
              fontSize: 20,
            ),
          ),
        ),
      ),
    ]);
  }
}
