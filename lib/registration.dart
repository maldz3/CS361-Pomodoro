import 'package:flutter/material.dart';
import 'services/auth.dart';

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
      appBar: AppBar(
        title: Text("Register a ScrumBags account"),
        elevation: 0.0
      ),
      // Body
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Username box              
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Name"
                ),
                validator: (val) => val.isEmpty ? "Enter a username" : null,
                onChanged: (val) {
                  setState(() => _username = val);
                }
              ),
              // Email box
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email"
                ),
                validator: (val) => val.isEmpty ? "Enter an email" : null,
                onChanged: (val) {
                  setState(() => _email = val);
                }
              ),
              // Password box 
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Passsword"
                ),
                validator: (val) => val.length < 6 ? "Password must be 6 or more characters" : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => _password = val);
                }
              ),
              // Register button
              SizedBox(height: 20.0),
              RaisedButton( 
                child: Text("Register now"),
                onPressed: () async {
                  // Check validation
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _auth.register(_username, _email, _password);

                    // Error catch
                    if (result == null) {
                       setState(() => _error = "Registration error!");
                    } else {
                      Navigator.of(context).pop();
                    }
                    // print(_username);
                    // print(_email);
                    // print(_password);
                  }
                }
              ),
              // Error box
              SizedBox(height: 20.0),
              Text(
                _error,
                style: TextStyle(color: Colors.red, fontSize: 20),
              )
            ]
          )   
        
        )
      )
    );
  }
}