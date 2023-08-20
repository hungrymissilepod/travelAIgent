import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/models/who_am_i_model.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/common/cta_button.dart';
import 'package:travel_aigent/ui/views/register/ui/register_view_password_text_form_field.dart';

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
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
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
              // TODO: use sliver scroll view here so that avatar widget shrinks down when scrolling
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () => viewModel.onAvatarTapped(),
                        child: CircleAvatar(
                          radius: 80,
                          child: Text(
                            viewModel.userAvatarString,
                            style: const TextStyle(fontSize: 80),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const ProfileCheatSection(),
                    ProfileInfoTile(
                      title: 'Name',
                      content: '${viewModel.whoAmI.name}',
                      onTap: () {},
                    ),
                    ProfileInfoTile(
                      title: 'Email',
                      content: '${viewModel.user?.email}',
                      onTap: () {},
                    ),
                    ProfileInfoTile(
                      title: 'Password',
                      content: '•••••••••••',
                      onTap: () {},
                    ),
                    const ProfileTemperatureTile(),
                    const Divider(thickness: 0.6),
                    InkWell(
                      onTap: () {
                        print('navigate to About page');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'About',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            FaIcon(
                              FontAwesomeIcons.chevronRight,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(thickness: 0.6),
                    InkWell(
                      onTap: () {
                        print('navigate to terms');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            FaIcon(
                              FontAwesomeIcons.arrowUpRightFromSquare,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(thickness: 0.6),
                    InkWell(
                      onTap: () {
                        print('navigate to privacy');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              'Privacy Policy',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            FaIcon(
                              FontAwesomeIcons.arrowUpRightFromSquare,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(thickness: 0.6),
                    InkWell(
                      onTap: () => viewModel.onDeleteAccountTapped(),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Delete Account',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(thickness: 0.6),
                    const SizedBox(height: 20),
                    // TextButton(
                    //   onPressed: viewModel.testOnBoarding,
                    //   child: const Text('test onboarding'),
                    // ),
                    CTAButton(
                      onTap: viewModel.signOut,
                      label: 'Sign out',
                      isLoading: viewModel.busy(ProfileViewSection.signOutButton),
                    ),
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

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    super.key,
    required this.title,
    required this.content,
    required this.onTap,
  });

  final String title;
  final String content;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () => onTap(),
                child: const Icon(
                  Icons.edit,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const Divider(thickness: 0.6),
        ],
      ),
    );
  }
}

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.focusNode,
    required this.hasError,
    required this.icon,
    required this.controller,
    required this.child,
  });

  final FocusNode focusNode;
  final bool hasError;
  final IconData icon;
  final TextEditingController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: textFieldContainerPadding),
      decoration: textFieldDecoration(focusNode, hasError),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: textFieldIconSizedBoxWidth,
            child: FaIcon(
              icon,
              color: Theme.of(context).primaryColor,
              size: textFieldIconSize,
            ),
          ),
          const SizedBox(width: textFieldIconSpacer),
          child,
        ],
      ),
    );
  }
}

class ProfileTemperatureTile extends ViewModelWidget<ProfileViewModel> {
  const ProfileTemperatureTile({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Temperature unit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        InkWell(
          onTap: () => viewModel.setMeasurementSystem(MeasurementSystem.metric),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Celcius (°C)',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Icon(
                  Icons.check,
                  color: viewModel.userSelectedMeasurementSystem(MeasurementSystem.metric) ? Colors.green : Colors.grey,
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        InkWell(
          onTap: () => viewModel.setMeasurementSystem(MeasurementSystem.imperial),
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Farenheit (°F)',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Icon(
                  Icons.check,
                  color:
                      viewModel.userSelectedMeasurementSystem(MeasurementSystem.imperial) ? Colors.green : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileCheatSection extends ViewModelWidget<ProfileViewModel> {
  const ProfileCheatSection({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Visibility(
      visible: viewModel.cheatsOn,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Cheats',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => viewModel.testOnBoarding(),
            child: const Text(
              'Test OnBoardingCarousel',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => viewModel.onDestinationValidationTapped(),
            child: Text(
              'Destination validation disabled: ${viewModel.destinationValidationDisabled}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const Divider(thickness: 0.6),
        ],
      ),
    );
  }
}
