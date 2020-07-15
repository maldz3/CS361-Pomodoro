import 'package:flutter/material.dart';
import 'package:pomodoro/components/menu.dart';
import 'package:pomodoro/components/build_drawer.dart';
import 'package:pomodoro/services/auth.dart';

// Logged in page

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          // Logout button
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("logout"),
              onPressed: () async {
                await _auth.signOut();
              }
            )
          ]
        ),
        drawer: BuildDrawer(),
        body: Center(
            child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/timer');
                },
                child: Text('Testing Routes'))));
  }
}
