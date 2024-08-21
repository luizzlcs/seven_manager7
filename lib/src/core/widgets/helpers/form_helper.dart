import 'package:flutter/material.dart';

void unfocus(BuildContext context) => FocusScope.of(context).unfocus();


//Cahme o método assim em cada campo:  onTapOutside: (_) => context.unfocus(), u

extension UnFocusExtension on BuildContext{
  void unfocus() => FocusScope.of(this).unfocus();

}