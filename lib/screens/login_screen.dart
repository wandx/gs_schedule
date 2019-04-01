import 'package:flutter/material.dart';
import 'package:gs_schedule/app_provider.dart';
import 'package:gs_schedule/models/credential.dart';
import 'package:gs_schedule/widgets/forms.dart';
import 'package:gs_schedule/widgets/misc.dart';
import 'package:gs_schedule/widgets/scaffold_wrapper.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  final LocalCred _cred = new LocalCred();

  @override
  Widget build(BuildContext context) {
    final appProvider =
        ScopedModel.of<AppProvider>(context, rebuildOnChange: true);
    return ScaffoldWrapper(
      isLoading: appProvider.globalLoading,
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
//              image: DecorationImage(
//                image: AssetImage("assets/img/bg.jpg"),
//                fit: BoxFit.cover,
//              ),
                color: Colors.black,
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: new Container(
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            _Logo(),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  CustomTextField(
                                    placeHolder: "Username",
                                    onChange: (v) {
                                      _cred.username = v;
                                    },
                                  ),
                                  CustomTextField(
                                    placeHolder: "Password",
                                    onChange: (v) {
                                      _cred.password = v;
                                    },
                                    secure: true,
                                  ),
                                  SubmitButton(
                                    text: "Masuk",
                                    onTap: () {
                                      _handleLogin(context);
                                    },
                                  ),
                                  ForgotPasswordText(
                                    onTap: () {
                                      print("forgot");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context) async {
    final appProvider =
        ScopedModel.of<AppProvider>(context, rebuildOnChange: true);

    if (_cred.username.isEmpty) {
      ShowToast(text: "Username diperlukan");
      return;
    }

    if (_cred.password.isEmpty) {
      ShowToast(text: "Password diperlukan");
      return;
    }

    appProvider.setGlobalLoading = true;
    Credential c =
        new Credential(username: _cred.username, password: _cred.password);
    await appProvider.doLogin(c).then((_) {
      if (!appProvider.loggedIn) {
        appProvider.setGlobalLoading = false;
        ShowToast(text: "Periksa username/password anda");
      }
    });
  }
}

class LocalCred {
  String username;
  String password;

  LocalCred({this.username = "", this.password = ""});
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height *
            (MediaQuery.of(context).size.height > 640.0 ? 0.3 : 0.23),
        bottom: 30.0,
      ),
      child: Center(
        child: Image(
          image: AssetImage("assets/img/icon.png"),
          width: 90.0,
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Color iconColor;

  _CircleButton({
    @required this.color,
    @required this.icon,
    this.iconColor = Colors.black,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: this.color,
      ),
      width: 45.0,
      height: 45.0,
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
