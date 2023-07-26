import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/views/register/register_viewmodel.dart';
import 'package:travel_aigent/ui/views/register/ui/password_validation_row.dart';
import 'package:travel_aigent/ui/views/register/ui/register_view_text_form_field.dart';

class RegisterViewPasswordTextFormField
    extends ViewModelWidget<RegisterViewModel> {
  const RegisterViewPasswordTextFormField({super.key});

  @override
  Widget build(BuildContext context, RegisterViewModel viewModel) {
    return Column(
      children: <Widget>[
        RegisterViewTextFormField(
          obscureText: viewModel.obscurePasswordText,
          autocorrect: false,
          controller: viewModel.passwordController,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.none,
          hintText: 'Password',
          prefixIcon: Icons.key,
          suffixIcon: Icons.check,
          suffixIconColor: viewModel.getSuffixIconColor(
              viewModel.passwordController, viewModel.hasAnyPasswordError()),
          onChanged: (String? value) => viewModel.validatePassword(),
          enabledBorderColor:
              viewModel.getEnabledBorderColor(viewModel.hasAnyPasswordError()),
          focusedBorderColor:
              viewModel.getFocusedBorderColor(viewModel.hasAnyPasswordError()),
          child: const SizedBox(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PasswordValidationRow(
                  label: 'One lowercase character',
                  hasError: viewModel.hasPasswordLowerCaseCharacterError,
                ),
                PasswordValidationRow(
                  label: 'One uppercase character',
                  hasError: viewModel.hasPasswordUpperCaseCharacterError,
                ),
                PasswordValidationRow(
                  label: 'One number',
                  hasError: viewModel.hasPasswordOneNumberError,
                ),
                PasswordValidationRow(
                  label: '8 characters minimum',
                  hasError: viewModel.hasPasswordCharacterMinimumError,
                ),
                PasswordValidationRow(
                  label: 'One special character',
                  hasError: viewModel.hasPasswordOneSpecialCharacter,
                ),
              ],
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => viewModel.toggleObscurePasswordText(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        viewModel.obscurePasswordText ? 'Show' : 'Hide',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(viewModel.obscurePasswordText
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
