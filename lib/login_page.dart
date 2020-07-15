import 'package:flutter/material.dart';
import 'services/auth.dart';

class LogIn extends StatefulWidget {
  
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  
  // Hold form data
  String _email = "";
  String _password = "";

  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Title Bar
      appBar: AppBar(
        title: Text("Sign in to ScrumBags"),
        elevation: 0.0
      ),
      // Body
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Form(
          child: Column(
            children: <Widget>[
              // Email box              
              SizedBox(height: 20.0),
              TextFormField(
                onChanged: (val) {
                  setState(() => _email = val);
                }
              ),
              // Password box
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                onChanged: (val) {
                  setState(() => _password = val);
                }
              ),
              // Login button
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Log in"),
                onPressed: () async {
                  dynamic result = await _auth.signIn(_email, _password);
                  
                }
              )
            ]
          )   
        
        )
      )
    );
    // return Container(
      
    // );
  }
}