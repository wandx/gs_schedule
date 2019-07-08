import 'package:flutter/material.dart';
import 'package:gs_schedule/states/app_state.dart';
import 'package:gs_schedule/ui/screens/landing.dart';
import 'package:gs_schedule/ui/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home/account_screen.dart';
import 'home/gallery_screen.dart';
import 'home/history_screen.dart';
import 'home/info_screen.dart';

class Entry extends StatelessWidget {
  final _appState = AppState();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _appState.init(),
      builder: (context, AsyncSnapshot<void> s) {
        if (s.connectionState == ConnectionState.done) {
          return ScopedModel<AppState>(
            model: _appState,
            child: Root(),
          );
        }

        return Landing();
      },
    );
  }
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = ScopedModel.of<AppState>(context, rebuildOnChange: true);

    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
      theme: ThemeData.dark(),
      home: state.model.isLoggedIn ? SetHome() : LoginScreen(),
    );
  }
}

class SetHome extends StatefulWidget {
  @override
  _SetHomeState createState() => _SetHomeState();
}

class _SetHomeState extends State<SetHome> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 4,
      initialIndex: 0,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "GRAMSHOOT",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(child: Text("HOME")),
            Tab(child: Text("ACCOUNTS")),
            Tab(child: Text("HISTORY")),
            Tab(child: Text("INFO")),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          GalleryScreen(),
          AccountScreen(),
          HistoryScreen(),
          InfoScreen(),
        ],
      ),
    );
  }
}
