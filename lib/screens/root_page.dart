import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/services/auth.dart';
import 'package:pomodoro/our_models.dart';
import 'package:pomodoro/our_screens.dart';

class RootPage extends StatefulWidget {
  @override
  RootPageState createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  User user;
  bool desireDebug = false;
  Future<FirebaseUser> futureFBUserInit;

  @override
  void initState() {
    print('init state called on root page');
    super.initState();
    user = User.getInstance();

    if (desireDebug)
      futureFBUserInit = AuthService.signIn(
          "s@m.com", "password"); // put your info here to get to your account
  }

  @override
  Widget build(BuildContext context) {
    if (desireDebug) {
      return FutureBuilder<FirebaseUser>(
        future: futureFBUserInit,
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            user = User.getInstance();
            return HomePage();
          } else if (snapshot.hasError) {
            children = <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 30,
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Creating debug user...',
                    style: TextStyle(fontSize: 16)),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      );
    } else {
      final user = User.getInstance();
      String message = 'root page hit. User is: ' +
          ((user == null) ? 'null.' : 'initialized.');

      return StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (_, snapshot) {
            if (snapshot.data is FirebaseUser && snapshot.data != null) {
              User.initialize(snapshot.data);
              print(message + ' Routing to home page');
              return HomePage();
            }
            print(message + ' Routing to login');
            return LogIn();
          });
    }
  }
}
