import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [];

    for (int i = 0; i < 30; i++) {
      _children.add(
        GridTile(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
            ),
            child: FadeInImage(
              fit: BoxFit.fitWidth,
              placeholder: AssetImage("assets/img/default.png"),
              image: NetworkImage(
                "https://placehold.it/300",
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        children: _children,
      ),
    );
  }
}
