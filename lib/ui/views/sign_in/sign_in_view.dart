import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/common_app_bar.dart';
import 'package:travel_aigent/ui/common/common_error_view.dart';
import 'package:travel_aigent/ui/common/common_safe_area.dart';
import 'package:travel_aigent/ui/common/common_text_form_field.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'sign_in_viewmodel.dart';

class SignInView extends StackedView<SignInViewModel> {
  const SignInView({
    Key? key,
    this.requiresReauthentication = false,
    this.showSignUpButton = true,
  }) : super(key: key);

  final bool requiresReauthentication;
  final bool showSignUpButton;

  @override
  Widget builder(
    BuildContext context,
    SignInViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CommonAppBar(
        title: 'Welcome Back!',
        showBackButton: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.transparent,
          child: CommonSafeArea(
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

                        /// TODO: enable forgot password flow after MVP
                        Visibility(
                          visible: false,
                          child: Row(
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
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CTAButton(
                        onTap: viewModel.onLoginTap,
                        label: 'Sign in',
                        isLoading: viewModel.isBusy,
                      ),
                      KeyboardVisibilityBuilder(
                        builder: (BuildContext context, bool isKeyboardVisible) {
                          if (!isKeyboardVisible) {
                            return Visibility(
                              visible: showSignUpButton,
                              child: Column(
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
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
                            );
                          }
                          return const SizedBox.shrink();
                        },
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
      SignInViewModel(requiresReauthentication: requiresReauthentication);
}
