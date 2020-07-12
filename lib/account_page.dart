import 'package:flutter/material.dart';
import 'package:pomodoro/models/user.dart';

class AccountPage extends StatelessWidget {
  User curUser = User('Test username', 'Test email', 'test password');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        pageTitle(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            rowBuilder('Username: ', 'Email :'),
            FlatButton(child: Text('Change Password'), onPressed: () {}),
            FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                splashColor: Colors.redAccent,
                child: Text('Remove Account Data'),
                onPressed: () {})
          ],
        )
      ],
    );
  }

  Widget pageTitle() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Account Page',
            style: TextStyle(fontSize: 25.0, height: 2.0)));
  }

  Widget rowBuilder(String title1, String title2) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title1),
            Padding(padding: EdgeInsets.all(8)),
            Text(title2),
          ]),
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(curUser.username),
            Padding(padding: EdgeInsets.all(8)),
            Text(curUser.email),
          ]),
      Column(children: [
        FlatButton(
            color: Colors.blueGrey,
            textColor: Colors.white,
            splashColor: Colors.blueAccent,
            padding: EdgeInsets.all(8.0),
            child: Text('Update'),
            onPressed: () {}),
        FlatButton(
            color: Colors.blueGrey,
            textColor: Colors.white,
            splashColor: Colors.blueAccent,
            padding: EdgeInsets.all(8.0),
            child: Text('Update'),
            onPressed: () {})
      ]),
    ]);
  }
}
