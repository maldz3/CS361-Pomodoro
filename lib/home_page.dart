import 'package:flutter/material.dart';
import 'package:pomodoro/components/build_drawer.dart';
import 'package:pomodoro/services/auth.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import 'models/user.dart';
import 'package:pomodoro/components/app_bar.dart';

// Logged in page

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
        appBar: CustomAppBar('Home Page'),
        /*AppBar(title: Text('Home Page'),
            // Logout button
            actions: <Widget>[
              FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("logout"),
                  onPressed: () async {
                    await _auth.signOut();
                  })
            ]),*/
        drawer: BuildDrawer(),
        body: Center(child: Text('No')));
  }
}
