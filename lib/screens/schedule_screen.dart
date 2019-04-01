import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gs_schedule/app_provider.dart';
import 'package:gs_schedule/widgets/bottom_nav.dart';
import 'package:gs_schedule/widgets/scaffold_wrapper.dart';
import 'package:scoped_model/scoped_model.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider =
        ScopedModel.of<AppProvider>(context, rebuildOnChange: true);

    return ScaffoldWrapper(
      isLoading: false,
      child: Scaffold(
        bottomNavigationBar: BottomNav(
          activeMenu: ActiveMenu.SCHEDULE,
          menuItem: <BottomNavItem>[
            BottomNavItem(
              icon: FontAwesomeIcons.home,
              onTap: () {
                appProvider.setActiveScreen = ActiveScreen.HOME;
              },
            ),
            BottomNavItem(
              icon: FontAwesomeIcons.userAstronaut,
              onTap: () {
                appProvider.setActiveScreen = ActiveScreen.ACCOUNT;
              },
            ),
            BottomNavItem(
              icon: FontAwesomeIcons.solidClock,
              isActive: true,
            ),
            BottomNavItem(
              icon: FontAwesomeIcons.user,
              onTap: () {
                appProvider.setActiveScreen = ActiveScreen.INFO;
              },
            ),
          ],
        ),
        body: Container(
          child: Center(
            child: Text("schedule list"),
          ),
        ),
      ),
    );
  }
}
