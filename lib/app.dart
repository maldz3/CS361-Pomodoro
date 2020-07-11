import 'package:flutter/material.dart';
import 'build_tabs.dart';

class App extends StatelessWidget {
  final String title;

  const App({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: BuildTabs(title: title),
        ));
  }
}
