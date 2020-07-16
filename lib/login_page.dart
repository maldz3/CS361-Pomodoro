import 'package:flutter/material.dart';
import 'services/auth.dart';
import 'registration.dart';

// Sign in page

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  // Hold form data
  String _email = "";
  String _password = "";
  String _error = "";

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Title Bar
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("ScrumBags Pomodoro"),
            elevation: 0.0),
        // Body
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  // Email box
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: InputDecoration(hintText: "Email"),
                      validator: (val) => val.isEmpty ? "Enter an email" : null,
                      onChanged: (val) {
                        setState(() => _email = val);
                      }),
                  // Password box
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: InputDecoration(hintText: "Password"),
                      validator: (val) => val.length < 6
                          ? "Password must be 6 or more characters"
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => _password = val);
                      }),
                  // Login button
                  SizedBox(height: 20.0),
                  RaisedButton(
                      child: Text("Log in"),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result =
                              await _auth.signIn(_email, _password);
                          if (result == null) {
                            setState(() => _error = "Invalid credentials");
                          }
                        }
                      }),
                  // Register account link
                  SizedBox(height: 20.0),
                  InkWell(
                      child: Text("Create Account"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      }),
                  // Error box
                  SizedBox(height: 20.0),
                  Text(
                    _error,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  )
                ]))));
  }
}
