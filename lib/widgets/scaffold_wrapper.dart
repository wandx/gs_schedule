import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

class ScaffoldWrapper extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  ScaffoldWrapper({@required this.child, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        this.child,
        Visibility(
          visible: this.isLoading,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5.0, sigmaX: 5.0),
            child: Container(
              color: Colors.black.withAlpha(200),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
