import 'package:flutter/material.dart';

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
          icon: Icons.settings,
          text: 'Settings',
          onTap: () => Navigator.pushNamed(context, '/settings')),
      createDrawerItem(
          icon: Icons.timer,
          text: 'Timer',
          onTap: () => Navigator.pushNamed(context, '/timer'))
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
