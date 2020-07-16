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
    final user1 = Provider.of<User>(context);
    return Scaffold(
        appBar: CustomAppBar('Home Page'),
        drawer: BuildDrawer(),
        body: Center(child: Text(user1.firebaseUser.displayName)));
  }
}
