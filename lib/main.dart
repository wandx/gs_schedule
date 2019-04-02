import 'package:flutter/material.dart';
import 'package:gs_schedule/app_provider.dart';
import 'package:gs_schedule/screens/landing.dart';
import 'package:gs_schedule/screens/root.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(Entry());
}

class Entry extends StatelessWidget {
  final _appProvider = new AppProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _appProvider.fetchLoginStatus(),
      builder: (context, AsyncSnapshot<bool> s) {
        if (s.connectionState == ConnectionState.done && !s.hasError) {
          _appProvider.fetchLoginStatus().then((bool res) async {
            await _appProvider.fetchMedia();
          }).then((_) async {
            await _appProvider.fetchAccount();
          }).then((_) {
            runApp(ScopedModel<AppProvider>(
              model: _appProvider,
              child: Root(),
            ));
          });
        }

        return Landing();
      },
    );
  }
}
