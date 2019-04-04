import 'package:flutter/material.dart';
import 'package:gs_schedule/app_provider.dart';
import 'package:gs_schedule/screens/account_screen.dart';
import 'package:gs_schedule/screens/add_account_screen.dart';
import 'package:gs_schedule/screens/add_gallery.dart';
import 'package:gs_schedule/screens/gallery_screen.dart';
import 'package:gs_schedule/screens/info_screen.dart';
import 'package:gs_schedule/screens/login_screen.dart';
import 'package:gs_schedule/screens/register_screen.dart';
import 'package:gs_schedule/screens/schedule_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider =
        ScopedModel.of<AppProvider>(context, rebuildOnChange: true);

    return MaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child),
      theme: ThemeData.dark(),
      home: appProvider.loggedIn
          ? SetHome(screen: appProvider.activeScreen)
          : LoginScreen(),
      routes: {
        "login": (context) => LoginScreen(),
        "register": (context) => RegisterScreen(),
        "add_gallery": (context) => AddGallery(),
        "add_account": (context) => AddAccountScreen(),
      },
    );
  }
}

class SetHome extends StatelessWidget {
  final ActiveScreen screen;

  SetHome({@required this.screen});

  @override
  Widget build(BuildContext context) {
    switch (screen) {
      case ActiveScreen.ACCOUNT:
        return AccountScreen();
        break;
      case ActiveScreen.SCHEDULE:
        return ScheduleScreen();
        break;
      case ActiveScreen.INFO:
        return InfoScreen();
        break;
      default:
        return GalleryScreen();
        break;
    }
  }
}
