import 'package:flutter/material.dart';
import 'package:pomodoro/services/auth.dart';
import 'package:pomodoro/our_models.dart';

// Registration page

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _email = "";
  String _password = "";
  String _username = "";
  String _error = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Title Bar
        appBar:
            AppBar(title: Text("Register a ScrumBags account"), elevation: 0.0),
        // Body
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  // Username box
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: InputDecoration(hintText: "Name"),
                      validator: (val) =>
                          val.isEmpty ? "Enter a username" : null,
                      onChanged: (val) {
                        setState(() => _username = val);
                      }),
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
                  // Register button
                  SizedBox(height: 20.0),
                  RaisedButton(
                      child: Text("Register now"),
                      onPressed: () async {
                        // Check validation
                        if (_formKey.currentState.validate()) {
                          dynamic result = await AuthService.register(
                              _username, _email, _password);

                          // Error catch
                          if (result == null || result.uid == null) {
                            setState(() => _error = "Registration error!");
                          } else {
                            //show registered dialogue
                            // Create new storage area for user in database
                            User.initDBEntry(result.uid, _username, _email);

                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.popUntil(
                                        context, ModalRoute.withName('/'));
                                  });
                                  return AlertDialog(
                                    title: Text(
                                        'Registered! Please log in to access your account.'),
                                  );
                                });
                            await AuthService.signOut();
                          }
                        }
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
