import 'package:flutter/material.dart';

class BuildDrawer extends StatelessWidget {
  BuildDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      createDrawerItem(
          icon: Icons.home,
          text: 'Task List',
          onTap: () => Navigator.popAndPushNamed(context, 'tasks')),
      createDrawerItem(
          icon: Icons.assessment,
          text: 'Stats',
          onTap: () => Navigator.popAndPushNamed(context, 'stats')),
      createDrawerItem(
          icon: Icons.settings,
          text: 'Settings',
          onTap: () => Navigator.popAndPushNamed(context, 'account')),
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
