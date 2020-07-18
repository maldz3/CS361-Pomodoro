import 'package:flutter/material.dart';
import 'package:pomodoro/timer_page.dart';
import 'package:pomodoro/account_page.dart';
import 'package:pomodoro/tasks_page.dart';

class BuildDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      createDrawerItem(
          icon: Icons.home,
          text: 'Home',
          onTap: () => Navigator.pushNamed(context, '/')),
      createDrawerItem(
          icon: Icons.list,
          text: 'Tasks',
          onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TasksPage()))
              }),
      createDrawerItem(
          icon: Icons.settings,
          text: 'Settings',
          onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AccountPage()))
              }),
      createDrawerItem(
          icon: Icons.timer,
          text: 'Timer',
          onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TimerPage()))
              })
    ]));
  }

  Widget createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
        title: Row(children: <Widget>[
          Icon(icon),
          Padding(padding: EdgeInsets.only(left: 5), child: Text(text))
        ]),
        onTap: onTap);
  }
}
