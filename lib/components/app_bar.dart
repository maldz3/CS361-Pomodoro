import 'package:flutter/cupertino.dart';
import 'package:pomodoro/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../our_models.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AuthService _auth = AuthService();
  final User user;

  CustomAppBar(this.title, this.user);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("logout"),
              onPressed: () async {
                await _auth.signOut();
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Phoenix.rebirth(context);
              })
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
