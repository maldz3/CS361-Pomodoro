import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MenuApp extends StatelessWidget implements PreferredSizeWidget {
  String title;

  MenuApp(String title){this.title = title;}

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title),
        leading: GestureDetector(
          onTap: () {},
          child: Icon(Icons.menu)
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/settings'),
                  child: Icon(Icons.settings)))
        ],
        );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
