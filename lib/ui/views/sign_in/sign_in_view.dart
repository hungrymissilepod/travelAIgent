import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/common_error_view.dart';
import 'package:travel_aigent/ui/common/common_text_form_field.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';

import 'sign_in_viewmodel.dart';

class SignInView extends StackedView<SignInViewModel> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignInViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                          'Welcome Back',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CommonErrorView(
                          visibile: viewModel.showErrorView,
                          message: viewModel.errorViewMessage,
                          onCloseTap: viewModel.onErrorCloseIconTap,
                        ),
                        CommonTextFormField(
                          controller: viewModel.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          hintText: 'Email',
                          prefixIcon: Icons.email,
                          suffixIconColor: Colors.grey,
                          onChanged: (String? value) => viewModel.onTextFieldChanged(),
                          enabledBorderColor: Colors.grey,
                          focusedBorderColor: Colours.accent,
                          child: const SizedBox(),
                        ),
                        CommonTextFormField(
                          controller: viewModel.passwordController,
                          obscureText: viewModel.obscurePasswordText,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.done,
                          hintText: 'Password',
                          prefixIcon: Icons.lock_rounded,
                          suffixIcon:
                              viewModel.obscurePasswordText ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                          suffixIconColor: Colors.grey,
                          onSuffixIconTap: viewModel.togglePasswordVisibility,
                          onChanged: (String? value) => viewModel.onTextFieldChanged(),
                          enabledBorderColor: Colors.grey,
                          focusedBorderColor: Colours.accent,
                          child: const SizedBox(),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: viewModel.onForgotPasswordTap,
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CTAButton(
                        onTap: viewModel.onLoginTap,
                        label: 'Log in',
                        isLoading: viewModel.isBusy,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'or',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CTAButton(
                        onTap: viewModel.onSignUpTap,
                        label: 'Sign up',
                        style: CTAButtonStyle.outline,
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
  SignInViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignInViewModel();
}
