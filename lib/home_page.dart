import 'package:flutter/material.dart';
import 'package:pomodoro/components/menu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MenuApp('Home Page'),
        body: Center(
            child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
                child: Text('Testing Routes'))));
  }
}
