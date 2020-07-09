import 'package:flutter/material.dart';
import 'package:pomodoro/account_page.dart';


class BuildTabs extends StatelessWidget {

  final String title;

  const BuildTabs({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        bottom:TabBar(
          tabs: [
            Tab(icon: Icon(Icons.timer)),
            Tab(icon: Icon(Icons.star)),
            Tab(icon: Icon(Icons.settings)),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          Placeholder(),
          Placeholder(),
          AccountPage(),
        ],
      )
    );
  }

}