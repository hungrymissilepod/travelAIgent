import 'package:flutter/material.dart';
import 'dart:core';

class RegisterViewTextFormFieldErrorText extends StatelessWidget {
  const RegisterViewTextFormFieldErrorText({
    super.key,
    required this.visible,
    required this.label,
  });

  final bool visible;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
