import 'home_page.dart';
import 'authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){

    // Get instance of User
    final user = Provider.of<User>(context);

    // Check user value to decide which page to show
    if (user != null) {
      return HomePage();
    } else {
      return Authenticate();
    } 

    // return Authenticate(); 
  }
}