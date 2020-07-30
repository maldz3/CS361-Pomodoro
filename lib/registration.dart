import 'package:flutter/material.dart';
import 'services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  final AuthService _auth = AuthService();
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
                          dynamic result = await _auth.register(
                              _username, _email, _password);

                          // Store user in database
                          Firestore db = Firestore.instance;
                          await db
                              .collection("users")
                              .document(result.uid)
                              .setData({
                            "uid": result.uid,
                            "username": _username,
                            "email": _email

                          });

                          // Error catch
                          if (result.uid == null) {
                            setState(() => _error = "Registration error!");
                          } else {
                            //show registered dialogue

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
                            await _auth.signOut();
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

  void snackBar(BuildContext context) {
    final snackBar = SnackBar
        content: Text(
            "Registration complete! Please log in to access your account."));

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
