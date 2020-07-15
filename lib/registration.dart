import 'package:flutter/material.dart';
import 'services/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String _email = "";
  String _password = "";
  String _username = "";

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Title Bar
      appBar: AppBar(
        title: Text("Register a ScrumBags account"),
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
              // Username box
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                onChanged: (val) {
                  setState(() => _username = val);
                }
              ),
              // Register button
              SizedBox(height: 20.0),
              RaisedButton( 
                child: Text("Register now"),
                onPressed: () async {
                  print(_email);
                  print(_password);
                }
              )
            ]
          )   
        
        )
      )
    );
  }
}