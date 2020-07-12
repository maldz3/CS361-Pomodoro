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
            rowBuilder('Username: ', 'Email :', context),
            FlatButton(
                child: Text('Change Password'),
                onPressed: () {
                  changePassword(context);
                }),
            FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                splashColor: Colors.redAccent,
                child: Text('Remove Account Data'),
                onPressed: () {
                  deleteData(context);
                })
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

  Widget rowBuilder(String title1, String title2, BuildContext context) {
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
            onPressed: () {
              changeName(context);
            }),
        FlatButton(
            color: Colors.blueGrey,
            textColor: Colors.white,
            splashColor: Colors.blueAccent,
            padding: EdgeInsets.all(8.0),
            child: Text('Update'),
            onPressed: () {
              changeEmail(context);
            })
      ]),
    ]);
  }

  void changeName(BuildContext context) {
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text('Update Username')),
          body: Center(
            child: FlatButton(
              child: Text('Click here to return'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    ));
  }

  void changeEmail(BuildContext context) {
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text('Update Email')),
          body: Center(
            child: FlatButton(
              child: Text('Click here to return'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    ));
  }

  void changePassword(BuildContext context) {
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text('Change Password')),
          body: Center(
            child: FlatButton(
              child: Text('Click here to return'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    ));
  }

  void deleteData(BuildContext context) {
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text('Remove Account Data')),
          body: Center(
            child: FlatButton(
              child: Text('Click here to return'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    ));
  }
}
