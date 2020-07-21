import 'package:flutter/material.dart';
import 'services/auth.dart';

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
  String _passResetEmail = "";

  AuthService _auth;
  final _formKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _auth = AuthService();
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
                          dynamic result = await _auth.signIn(_email, _password);
                          if (result.uid == null) {
                            setState(() => _error = "Invalid credentials");
                          }
                        }
                      }),
                  // Register account link
                  SizedBox(height: 20.0),
                  InkWell(
                      child: Text("Create Account"),
                      onTap: () {
                        Navigator.pushNamed(context, 'register');
                      }),
                  // Error box
                  SizedBox(height: 20.0),
                    InkWell(
                      child: Text("Forgot your password?  Click here."),
                      onTap: () async {
                        return showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Send Password Reset E-mail'),
                              content: Form(
                                key: _passwordKey,
                                child: Column(
                                  children: [
                                  SizedBox(height: 20.0),
                                  TextFormField(
                                  decoration: InputDecoration(hintText: "Email"),
                                  validator: (val) => val.isEmpty ? "Enter an email" : null,
                                  onChanged: (val) {
                                    setState(() => _passResetEmail = val);
                                  }),
                                  ])
                              ),
                              actions: [
                                RaisedButton(
                                  child: Text("Send"),
                                    onPressed: () {
                                      if (_passwordKey.currentState.validate()) {
                                        _auth.resetPassword(_passResetEmail);
                                        Navigator.pop(context);
                                      }
                                    }
                                ),
                              ],
                            );
                          }
                        );
                      }
                    ),
                  Text(
                    _error,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  )
                ]))));
  }
}
