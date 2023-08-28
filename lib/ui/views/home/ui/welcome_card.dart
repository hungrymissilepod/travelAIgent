import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/home/home_viewmodel.dart';

class WelcomeCard extends ViewModelWidget<HomeViewModel> {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: scaffoldHorizontalPadding),
      child: Container(
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
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Where to next?',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            Bounceable(
              onTap: viewModel.onProfileIconTapped,
              child: FaIcon(
                FontAwesomeIcons.solidCircleUser,
                color: Theme.of(context).primaryColor,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
