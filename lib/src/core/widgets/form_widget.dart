import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required this.label,
    required this.hintTex,
    this.obscureText = false
  });

  final String label;
  final String hintTex;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            obscureText: obscureText!,
            style: const TextStyle(
                color: Colors.blue), // Define a cor do texto aqui
            decoration: InputDecoration(
              hintText: hintTex,
              hintStyle: const TextStyle(
                  color: Colors.grey), // Define a cor do texto do placeholder
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
