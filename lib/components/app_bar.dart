import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:pomodoro/services/auth.dart';

import '../styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(centerTitle: true,
        title: Text(title),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Logout"),
              onPressed: () async {
                await AuthService.signOut();
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Phoenix.rebirth(context);
              })
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
