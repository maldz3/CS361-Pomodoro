import 'package:flutter/material.dart';
import 'package:pomodoro/our_screens.dart';


class App extends StatelessWidget {
  final String title;

  const App({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            title: title,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.black,
              brightness: Brightness.dark,
              accentColor: Colors.cyan,
              fontFamily: 'Rubik',
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => RootPage(),
              'account': (context) => AccountPage(),
              'addTask': (context) => TasksAddPage(),
              'register': (context) => Register(),
              'stats': (context) => StatsPage(),
              'timer': (context) => TimerPage()
            });
  }
}
