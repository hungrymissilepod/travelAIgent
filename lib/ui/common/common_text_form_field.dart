import 'package:flutter/material.dart';
import 'dart:core';

class CommonTextFormField extends StatelessWidget {
  const CommonTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.textCapitalization,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    required this.suffixIconColor,
    required this.onChanged,
    required this.child,
    required this.enabledBorderColor,
    required this.focusedBorderColor,
    this.obscureText = false,
    this.autocorrect = true,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final Function()? onSuffixIconTap;
  final Function(String?) onChanged;
  final Widget? child;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final bool obscureText;
  final bool autocorrect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            autocorrect: autocorrect,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            cursorColor: Theme.of(context).colorScheme.secondary,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: enabledBorderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: focusedBorderColor,
                ),
              ),
              errorStyle: const TextStyle(
                fontSize: 14,
              ),
              hintText: hintText,
              prefixIcon: Icon(prefixIcon),
              suffixIcon: suffixIcon == null
                  ? null
                  : GestureDetector(
                      onTap: onSuffixIconTap,
                      child: Icon(
                        suffixIcon,
                        color: suffixIconColor,
                      ),
                    ),
            ),
            onChanged: (String? value) => onChanged(value),
          ),
          child ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
