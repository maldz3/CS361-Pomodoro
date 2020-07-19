import 'package:flutter/material.dart';
import 'package:pomodoro/timer_page.dart';
import 'package:pomodoro/account_page.dart';
import 'package:pomodoro/tasks_page.dart';
import 'package:pomodoro/models/user.dart';

class BuildDrawer extends StatelessWidget {
  final User user;
  BuildDrawer(this.user);

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
                navPushPop(context,
                    MaterialPageRoute(
                      settings: RouteSettings(name: "/tasksPage"),
                      builder: (context) => TasksPage(user, this)))
              }),
      createDrawerItem(
          icon: Icons.settings,
          text: 'Settings',
          onTap: () => {
                navPushPop(context,MaterialPageRoute(builder: (context) => AccountPage(user, this)))
              }
            ),
      createDrawerItem(
          icon: Icons.timer,
          text: 'Timer',
          onTap: () => {
                navPushPop(context,
                    MaterialPageRoute(builder: (context) => TimerPage(user, this)))
              })
    ]));
  }

  // close the drawer before moving to next view
  void navPushPop(BuildContext context, MaterialPageRoute route) {
    Navigator.pop(context);
    Navigator.push(context, route);
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
