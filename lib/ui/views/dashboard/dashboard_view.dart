import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/home/home_view.dart';
import 'package:travel_aigent/ui/views/saved_plans/saved_plans_view.dart';

import 'dashboard_viewmodel.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DashboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: PageView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          controller: viewModel.pageController,
          onPageChanged: viewModel.onBottomNavBarTapped,
          children: <Widget>[
            const HomeView(),
            SavedPlansView(
              navigateToHomeView: viewModel.navigateToHomeView,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewModel.selectedPage,
        selectedItemColor: Colours.accent,
        unselectedItemColor: Colours.primary,
        selectedIconTheme: const IconThemeData(color: Colours.accent),
        unselectedIconTheme: const IconThemeData(color: Colours.primary),
        onTap: viewModel.onBottomNavBarTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.zero,
              child: FaIcon(
                FontAwesomeIcons.planeDeparture,
              ),
            ),
            label: 'Plan Trip',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: FaIcon(
                FontAwesomeIcons.solidBookmark,
              ),
            ),
            label: 'Saved Trips',
          ),
        ],
      ),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DashboardViewModel();
}
