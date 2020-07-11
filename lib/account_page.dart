import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        pageTitle(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            rowBuilder('Username: '),
            rowBuilder('Email: '),
            FlatButton(child: Text('Change Password'), onPressed: () {}),
            FlatButton(
                color: Colors.red,
                textColor: Colors.white,
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

  Widget rowBuilder(String title) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(title),
      Text('Placeholder'),
      FlatButton(
          color: Colors.blueGrey,
          textColor: Colors.white,
          padding: EdgeInsets.all(8.0),
          child: Text('Update'),
          onPressed: () {})
    ]);
  }
}
