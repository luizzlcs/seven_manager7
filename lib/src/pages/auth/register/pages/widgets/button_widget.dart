import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.function,
    required this.name,
    required this.icon,
  });

  final VoidCallback function;
  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: function,
      label: Text(name),
      icon: Icon(icon),
    );
  }
}
