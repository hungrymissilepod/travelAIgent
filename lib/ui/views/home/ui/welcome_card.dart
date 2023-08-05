import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/home/home_viewmodel.dart';

class WelcomeCard extends ViewModelWidget<HomeViewModel> {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                viewModel.welcomeMessage,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Where to?',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),

          /// TODO: show user image?
          /// Or just show first initial of name?
          viewModel.isUserLoggedIn()
              ? GestureDetector(
                  onTap: viewModel.onAvatarTap,
                  child: const CircleAvatar(
                    child: Text('J'),
                  ),
                )
              : TextButton(
                  onPressed: viewModel.onSignInTap,
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colours.accent,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
