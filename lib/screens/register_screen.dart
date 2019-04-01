import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: AssetImage("assets/img/im2.jpg"),
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
                                _LoginInput(placeHolder: "Username"),
                                _LoginInput(placeHolder: "Email"),
                                _LoginInput(placeHolder: "Password"),
                                _SubmitButton(),
                              ],
                            ),
                          ),
                          _Atau(),
                          Container(
                            margin: EdgeInsets.only(bottom: 20.0),
                            child: Center(
                              child: Text(
                                "Anda bisa daftar menggunakan",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                _CircleButton(
                                  color: Colors.white,
                                  icon: FontAwesomeIcons.google,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                _CircleButton(
                                  color: Colors.lightBlue,
                                  icon: FontAwesomeIcons.facebookF,
                                  iconColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                new Container(
                  height: 50.0,
                  color: Colors.white.withAlpha(100),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "login");
                    },
                    child: Center(
                      child: Text("Sudah memiliki akin? Login disini."),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height *
            (MediaQuery.of(context).size.height > 640.0 ? 0.3 : 0.16),
        bottom: 30.0,
      ),
      child: Center(
        child: Text(
          "LOGO",
          style: TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _LoginInput extends StatelessWidget {
  final String placeHolder;

  _LoginInput({@required this.placeHolder});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      margin: EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Container(
        height: 50.0,
        padding: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        color: Colors.white.withAlpha(70),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: this.placeHolder,
                hintStyle: TextStyle(
                  color: Colors.white,
                )),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      child: InkWell(
        enableFeedback: true,
        onTap: () {
          Navigator.pushReplacementNamed(context, "gallery");
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(70),
            border: Border.all(
              color: Colors.white.withAlpha(120),
              width: 2.0,
            ),
          ),
          height: 50.0,
          padding: EdgeInsets.only(
            left: 4.0,
            right: 4.0,
          ),
          child: Center(
            child: Text(
              "Daftar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Atau extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 20.0,
        bottom: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Divider(
              height: 2.0,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 5.0,
              right: 5.0,
            ),
            child: Text(
              "ATAU",
              style: TextStyle(
                color: Colors.white.withAlpha(180),
              ),
            ),
          ),
          Expanded(
            child: Divider(
              height: 2.0,
              color: Colors.white,
            ),
          ),
        ],
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
