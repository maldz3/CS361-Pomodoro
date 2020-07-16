import 'package:flutter/cupertino.dart';
import 'package:pomodoro/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pomodoro/root_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  final AuthService _auth = AuthService();

  CustomAppBar(String title) {
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title),
        //leading: GestureDetector(onTap: () {}),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("logout"),
              onPressed: () async {
                await _auth.signOut();
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RootPage()));
                
              }
          )
        ]
        );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
