import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.function,
    required this.name,
    required this.icon,
    required this.alignment,
  });

  final VoidCallback function;
  final String name;
  final IconData icon;
  final IconAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: function,
      iconAlignment: alignment,
      label: Text(name),
      icon: Icon(icon),
    );
  }
}
