import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'dart:core';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:travel_aigent/ui/views/register/ui/register_checkbox.dart';
import 'package:travel_aigent/ui/views/register/ui/register_view_password_text_form_field.dart';
import 'package:travel_aigent/ui/views/register/ui/register_view_text_form_field.dart';
import 'package:travel_aigent/ui/views/register/ui/register_view_text_form_field_error_text.dart';

import 'register_viewmodel.dart';

class RegisterView extends StackedView<RegisterViewModel> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // toolbarHeight: 0,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.transparent,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(scaffoldHorizontalPadding, 10, scaffoldHorizontalPadding, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Sign up with email',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        RegisterViewTextFormField(
                          controller: viewModel.fullNameController,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.none,
                          hintText: 'Full name',
                          prefixIcon: Icons.person,
                          suffixIcon: Icons.check,
                          suffixIconColor: viewModel.getSuffixIconColor(
                              viewModel.fullNameController, viewModel.hasErrorForKey(RegisterViewTextField.fullName)),
                          onChanged: (String? value) => viewModel.validateFullName(),
                          enabledBorderColor:
                              viewModel.getEnabledBorderColor(viewModel.hasErrorForKey(RegisterViewTextField.fullName)),
                          focusedBorderColor:
                              viewModel.getFocusedBorderColor(viewModel.hasErrorForKey(RegisterViewTextField.fullName)),
                          child: RegisterViewTextFormFieldErrorText(
                            visible: viewModel.hasErrorForKey(RegisterViewTextField.fullName),
                            label: 'Please enter your name',
                          ),
                        ),
                        RegisterViewTextFormField(
                          controller: viewModel.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          hintText: 'Email address',
                          prefixIcon: Icons.email,
                          suffixIcon: Icons.check,
                          suffixIconColor: viewModel.getSuffixIconColor(
                              viewModel.emailController, viewModel.hasErrorForKey(RegisterViewTextField.email)),
                          onChanged: (String? value) => viewModel.validateEmail(),
                          enabledBorderColor:
                              viewModel.getEnabledBorderColor(viewModel.hasErrorForKey(RegisterViewTextField.email)),
                          focusedBorderColor:
                              viewModel.getFocusedBorderColor(viewModel.hasErrorForKey(RegisterViewTextField.email)),
                          child: RegisterViewTextFormFieldErrorText(
                            visible: viewModel.hasErrorForKey(RegisterViewTextField.email),
                            label: 'Please enter a valid email',
                          ),
                        ),
                        const RegisterViewPasswordTextFormField(),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const RegisterCheckbox(),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding),
                        child: CTAButton(
                          onTap: viewModel.onRegisterTap,
                          label: 'Sign up',
                          enabled: viewModel.hasUserAgreedTerms,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  RegisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegisterViewModel();
}
