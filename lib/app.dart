import 'package:flutter/material.dart';
import 'account_page.dart';
import 'home_page.dart';
import 'timer_page.dart';
import 'root_page.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import 'models/user.dart';

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
            home: RootPage(),
            routes: {
              '/settings': (context) => AccountPage(),
              '/timer': (context) => TimerPage()
            }));
  }
}
