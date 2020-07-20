import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:pomodoro/models/user.dart';


class Authenticate extends StatefulWidget {
  final User user;
  Authenticate(this.user);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    final User user = this.widget.user;
    return Container(
      child: LogIn(user)
    ); 
  }
}
