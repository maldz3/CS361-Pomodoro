import 'package:flutter/material.dart';
import 'account_page.dart';
import 'home_page.dart';
import 'timer_page.dart';

class App extends StatelessWidget {
  final String title;

  const App({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/settings': (context) => AccountPage(),
          '/timer': (context) => TimerPage()
        });
  }
}
