import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.router.dart';
import 'package:travel_aigent/services/authentication_service.dart';

class SignInViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _requiredReauthentication = false;

  SignInViewModel({bool requiresReauthentication = false}) {
    _requiredReauthentication = requiresReauthentication;
  }

  bool obscurePasswordText = true;

  bool showErrorView = false;
  String errorViewMessage = '';

  void togglePasswordVisibility() {
    obscurePasswordText = !obscurePasswordText;
    rebuildUi();
  }

  void onErrorCloseIconTap() {
    showErrorView = false;
    rebuildUi();
  }

  void onTextFieldChanged() {
    rebuildUi();
  }

  void onForgotPasswordTap() {
    /// TODO: call a Firebase Cloud Function that will send a password reset email to the user
  }

  Future<void> onLoginTap() async {
    String? response;

    /// If user requires reauthentication
    if (_requiredReauthentication) {
      response = await runBusyFuture(
        _authenticationService.reauthenticateWithCredential(
          emailController.text,
          passwordController.text,
        ),
      );
    }

    /// Otherwise they log in normally
    else {
      response = await runBusyFuture(
        _authenticationService.signInWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        ),
      );
    }

    /// Check if we got an error message when creating account and show it here
    if (response != null) {
      errorViewMessage = _getErrorViewMessage(response);
      showErrorView = true;
      rebuildUi();
      return;
    }

    /// If we did not have any errors logging in
    return _navigationService.clearStackAndShow(Routes.dashboardView);
  }

  String _getErrorViewMessage(String? response) {
    switch (response) {
      case 'invalid-email':
        return 'Invalid email or password';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'user-not-found':
        return 'Invalid email or password';
      case 'wrong-password':
        return 'Invalid email or password';
      default:
        return 'An error occured, please try again.';
    }
  }

  void onSignUpTap() {
    _navigationService.navigateToRegisterView();
  }
}
