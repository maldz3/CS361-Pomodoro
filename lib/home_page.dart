import 'package:flutter/material.dart';
import 'package:pomodoro/components/build_drawer.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'package:pomodoro/models/user.dart';

// Logged in page

class HomePage extends StatefulWidget {
  User user;

  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    this.widget.user = ModalRoute.of(context).settings.arguments;
    User user = this.widget.user; 
    return Scaffold(
        appBar: CustomAppBar('Home Page', user),
        drawer: BuildDrawer(user),
        body: Center(child: Image.asset('assets/images/tomato.png')));
  }
}
