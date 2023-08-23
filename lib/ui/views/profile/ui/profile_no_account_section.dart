import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:travel_aigent/ui/views/profile/profile_viewmodel.dart';

class ProfileNoAccountSection extends ViewModelWidget<ProfileViewModel> {
  const ProfileNoAccountSection({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 60, 10, 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/passport.png',
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
          // const SizedBox(height: 20),
          const Text(
            'You are not signed in',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Create an account to access the\nfull benefits of Viajo!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          CTAButton(
            onTap: viewModel.onRegisterTapped,
            label: 'Create account',
          ),
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
            onTap: viewModel.onSignInTap,
            label: 'Sign in',
            style: CTAButtonStyle.outline,
          ),
        ],
      ),
    );
  }
}
