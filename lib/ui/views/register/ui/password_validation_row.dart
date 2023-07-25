import 'package:flutter/material.dart';
import 'dart:core';

class PasswordValidationRow extends StatelessWidget {
  const PasswordValidationRow({
    super.key,
    required this.hasError,
    required this.label,
  });

  final bool hasError;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.check,
          color: hasError ? Colors.grey : Colors.green,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(label),
      ],
    );
  }
}
