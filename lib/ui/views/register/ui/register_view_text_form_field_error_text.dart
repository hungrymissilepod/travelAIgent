import 'package:flutter/material.dart';
import 'dart:core';

class RegisterViewTextFormFieldErrorText extends StatelessWidget {
  const RegisterViewTextFormFieldErrorText({
    super.key,
    required this.visible,
    required this.label,
    this.topPadding = 8.0,
  });

  final bool visible;
  final String label;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Row(
          children: <Widget>[
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
