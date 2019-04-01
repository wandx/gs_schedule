import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gs_schedule/app_provider.dart';
import 'package:gs_schedule/widgets/bottom_nav.dart';
import 'package:gs_schedule/widgets/scaffold_wrapper.dart';
import 'package:scoped_model/scoped_model.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider =
        ScopedModel.of<AppProvider>(context, rebuildOnChange: true);

    return ScaffoldWrapper(
      isLoading: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: Visibility(
          visible: appProvider.user.package.accountCount >=
              appProvider.accounts.length,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, "add_account");
            },
            child: Icon(FontAwesomeIcons.plus),
          ),
        ),
        bottomNavigationBar: BottomNav(
          activeMenu: ActiveMenu.ACCOUNT,
          menuItem: <BottomNavItem>[
            BottomNavItem(
              icon: FontAwesomeIcons.home,
              onTap: () {
                appProvider.setActiveScreen = ActiveScreen.HOME;
              },
            ),
            BottomNavItem(
              icon: FontAwesomeIcons.userAstronaut,
              isActive: true,
            ),
//            BottomNavItem(
//              icon: FontAwesomeIcons.solidClock,
//              onTap: () {
//                appProvider.setActiveScreen = ActiveScreen.SCHEDULE;
//              },
//            ),
            BottomNavItem(
              icon: FontAwesomeIcons.user,
              onTap: () {
                appProvider.setActiveScreen = ActiveScreen.INFO;
              },
            ),
          ],
        ),
        body: Container(
          color: Colors.black,
          child: appProvider.accounts.length == 0
              ? Center(
                  child: Text(
                    "Tidak ada data",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: appProvider.accounts.length,
                  itemBuilder: (BuildContext context, index) => Card(
                        child: ListTile(
                          title:
                              Text("${appProvider.accounts[index].username}"),
                          trailing: IconButton(
                            icon: Icon(FontAwesomeIcons.trash),
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Hapus akun"),
                                    content: Text(
                                        "Akun ${appProvider.accounts[index].username} akan dihapus"),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Batal"),
                                      ),
                                      FlatButton(
                                        onPressed: () async {
                                          await appProvider
                                              .removeInstagramAccount(
                                                  appProvider
                                                      .accounts[index].id);
                                          await appProvider.fetchAccount();
                                          Navigator.pop(context);
                                        },
                                        child: Text("Hapus"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )),
        ),
      ),
    );
  }
}
