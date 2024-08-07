import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';

class SevenLoader extends StatelessWidget {
  const SevenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: SevenManagerTheme.tealBlue,
        size: 60,
      ),
    );
  }
}