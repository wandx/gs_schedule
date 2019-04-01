import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gs_schedule/app_provider.dart';
import 'package:gs_schedule/widgets/bottom_nav.dart';
import 'package:gs_schedule/widgets/scaffold_wrapper.dart';
import 'package:scoped_model/scoped_model.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider =
        ScopedModel.of<AppProvider>(context, rebuildOnChange: true);

    return ScaffoldWrapper(
      isLoading: appProvider.globalLoading,
      child: Scaffold(
        backgroundColor: Colors.black,
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
//            BottomNavItem(
//              icon: FontAwesomeIcons.solidClock,
//              onTap: () {
//                appProvider.setActiveScreen = ActiveScreen.SCHEDULE;
//              },
//            ),
            BottomNavItem(
              icon: FontAwesomeIcons.user,
              isActive: true,
            ),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Username: "),
                  Text("${appProvider.user.username}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Paket: "),
                  Text("${appProvider.user.package.name}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Expired: "),
                  Text(
                      "${appProvider.user.expiredAt != null ? _parseDate(appProvider.user.expiredAt) : '-'}"),
                ],
              ),
              RaisedButton(
                onPressed: () {
                  appProvider.doLogout();
                },
                child: Text("Keluar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _parseDate(String date) {
    DateTime dt = DateTime.parse(date);
    return formatDate(dt, [d, " ", MM, " ", yyyy]).toString();
  }
}
