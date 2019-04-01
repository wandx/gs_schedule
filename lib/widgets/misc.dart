import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gs_schedule/widgets/config.dart' as config;

class SeparatorWithText extends StatelessWidget {
  final String text;

  SeparatorWithText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: config.paddingLeft,
        right: config.paddingRight,
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
              text,
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

class ForgotPasswordText extends StatelessWidget {
  final VoidCallback onTap;

  ForgotPasswordText({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: config.paddingLeft,
        right: config.paddingRight,
        top: config.paddingTop,
      ),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          child: Text(
            "Lupa password anda? Tap disini.",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.end,
          ),
        ),
      ),
    );
  }
}

class ShowToast {
  final String text;

  ShowToast({@required this.text}) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
//      backgroundColor: Colors.red,
//      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

class CustomGridTile extends StatelessWidget {
  final String path;
  final String caption;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  CustomGridTile({
    @required this.path,
    this.selected = false,
    this.onTap,
    this.onLongPress,
    this.caption = "tidak ada caption",
  });

  @override
  Widget build(BuildContext context) {
    final _im = _validateFilePath(path);
    return GridTile(
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: EdgeInsets.all(selected ? 8.0 : 0.0),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image(
                image: _im,
                fit: BoxFit.cover,
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    child: Text(""),
                  ),
                  Container(
                    height: 40.0,
                    color: Colors.black.withAlpha(150),
                    child: Center(
                      child: Text(
                        caption,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider _validateFilePath(String path) {
    final check = File(path).existsSync();

    if (check) {
      return FileImage(File(path));
    }

    return AssetImage("assets/img/default.png");
  }
}
