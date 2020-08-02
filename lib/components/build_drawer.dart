import 'package:flutter/material.dart';
import '../our_models.dart';

class BuildDrawer extends StatelessWidget {
  final User user;
  BuildDrawer(this.user);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      createDrawerItem(
          icon: Icons.home,
          text: 'Task List',
          onTap: () => Navigator.popAndPushNamed(context, '/')),
      createDrawerItem(
          icon: Icons.settings,
          text: 'Settings',
          onTap: () =>
              Navigator.popAndPushNamed(context, 'account', arguments: user)),
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
