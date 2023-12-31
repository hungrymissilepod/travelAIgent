import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/views/plan/ui/plan_view_loaded_state.dart';
import 'package:travel_aigent/ui/views/profile/profile_viewmodel.dart';
import 'package:travel_aigent/ui/views/profile/ui/profile_info_tile.dart';
import 'package:travel_aigent/ui/views/profile/ui/profile_section_header.dart';
import 'package:travel_aigent/ui/views/profile/ui/profile_tile.dart';

class ProfileAccountSection extends ViewModelWidget<ProfileViewModel> {
  const ProfileAccountSection({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const ProfileSectionHeader(
          label: 'Account',
        ),
        ProfileInfoTile(
          title: 'Name',
          content: '${viewModel.whoAmI.name}',
          onTap: viewModel.onNameFieldTapped,
        ),
        const Divider(),
        ProfileInfoTile(
          title: 'Email',
          content: '${viewModel.user?.email}',
          onTap: () {},
          showEditIcon: false,
        ),
        const Divider(),
        ProfileInfoTile(
          title: 'Password',
          content: '•••••••••••',
          onTap: () {},
          showEditIcon: false,
        ),
        const Divider(),
        ProfileTile(
          label: 'Sign Out',
          labelStyle: const TextStyle(
            fontSize: 20,
          ),
          onTap: viewModel.signOut,
          isLoading: viewModel.busy(ProfileViewSection.signOutButton),
        ),
        const Divider(),
        const SizedBox(height: bigSpacer),
      ],
    );
  }
}
