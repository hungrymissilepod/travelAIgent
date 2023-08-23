import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/profile/ui/profile_account_section.dart';
import 'package:travel_aigent/ui/views/profile/ui/profile_cheat_section.dart';
import 'package:travel_aigent/ui/views/profile/ui/profile_no_account_section.dart';
import 'package:travel_aigent/ui/views/profile/ui/profile_section_header.dart';
import 'package:travel_aigent/ui/views/profile/ui/profile_temperature_tile.dart';
import 'package:travel_aigent/ui/views/profile/ui/profile_tile.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: GestureDetector(
          onDoubleTap: viewModel.onAvatarTapped,
          child: Text(
            viewModel.welcomeMessage,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                      visible: viewModel.cheatsOn,
                      child: const ProfileCheatSection(),
                    ),
                    viewModel.isUserLoggedIn() ? const ProfileAccountSection() : const ProfileNoAccountSection(),
                    const ProfileSectionHeader(
                      label: 'General',
                    ),
                    const ProfileTemperatureTile(),
                    const SizedBox(height: 40),
                    const ProfileSectionHeader(
                      label: 'Legal Stuff',
                    ),
                    ProfileTile(
                      label: 'About',
                      icon: FontAwesomeIcons.chevronRight,
                      onTap: viewModel.onAboutTapped,
                    ),
                    const Divider(),

                    /// TODO: go to correct terms page
                    ProfileTile(
                      label: 'Terms and Conditions',
                      icon: FontAwesomeIcons.arrowUpRightFromSquare,
                      onTap: viewModel.onTermsTapped,
                    ),
                    const Divider(),

                    /// TODO: go to correct privacy page
                    ProfileTile(
                      label: 'Privacy Policy',
                      icon: FontAwesomeIcons.arrowUpRightFromSquare,
                      onTap: viewModel.onPrivacyTapped,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();
}
