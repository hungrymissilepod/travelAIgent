import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';
import 'package:travel_aigent/ui/views/home/home_view.dart';

import 'dashboard_viewmodel.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DashboardViewModel viewModel,
    Widget? child,
  ) {
    /// TODO: status bar needs to be same as background image
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: PageView(
          controller: viewModel.pageController,
          onPageChanged: viewModel.onBottomNavBarTapped,
          children: const <Widget>[
            HomeView(),
            Center(child: Text('saved trips here')),
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
              padding: EdgeInsets.only(bottom: 8),
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
