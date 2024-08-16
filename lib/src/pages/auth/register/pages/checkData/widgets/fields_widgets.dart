import 'package:flutter/material.dart';

class FieldsWidgets extends StatelessWidget {
  const FieldsWidgets({super.key, required this.field});
  final String field;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(field),
    );
  }
}
