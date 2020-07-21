import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'models/user.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Generate the grand placeholder of the user
    User user = Provider.of<User>(context); // would love to get rid of this provider, I think it's more trouble than it's worth.

    // Check user value to decide which page to show
    if (user != null) {
      return HomePage(user);
    } else {
      return LogIn();
    }
  }
}
