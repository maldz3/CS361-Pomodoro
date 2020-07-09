import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        pageTitle()
      ],
    );
  }

  Widget pageTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Account Page',
        style: TextStyle(
          fontSize: 25.0,
          height: 2.0
        )
      )
    );
  }

}