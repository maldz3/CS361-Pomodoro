import 'package:flutter/material.dart';
import 'package:pomodoro/account_page.dart';
import 'package:pomodoro/home_page.dart';
import 'package:pomodoro/timer_page.dart';
import 'root_page.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import 'models/user.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'registration.dart';

class App extends StatelessWidget {
  final String title;

  const App({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().userAuth,
      child: MaterialApp(
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
            'timer': (context) => TimerPage(),
          }
      )
    );
  }
}
