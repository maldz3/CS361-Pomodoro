import 'home_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'our_models.dart';



class RootPage extends StatefulWidget {
  @override
  RootPageState createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  User user;

  @override
  void initState() {
    super.initState();
    user = User.getInstance();
  }

  void resetState() {
    setState(() {user = User.getInstance();});
  }

  @override
  Widget build(BuildContext context) {
    final user = User.getInstance();
    print('root page hit. User is: ' + ((user == null)? 'null' : 'initialized'));
    // Check user value to decide which page to show
    if (user != null) {
      return HomePage();
    } else {
      return LogIn(resetState);
    }
  }
}