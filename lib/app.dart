import 'package:flutter/material.dart';
import 'services/auth.dart';
import 'package:pomodoro/account_page.dart';
import 'package:pomodoro/our_models.dart';
import 'package:pomodoro/registration.dart';
import 'package:pomodoro/root_page.dart';
import 'package:pomodoro/tasks_add_page.dart';
import 'package:pomodoro/timer_page.dart';

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
              '/': (context) => RootPage(),
              'account': (context) => AccountPage(),
              'register': (context) => Register(),
              'addTask': (context) => TasksAddPage(),
              'timer': (context) => TimerPage()
            });
  }
}
