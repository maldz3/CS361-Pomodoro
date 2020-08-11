import 'package:flutter/material.dart';
import 'package:pomodoro/services/auth.dart';
import 'package:pomodoro/our_models.dart';
import 'package:pomodoro/styles.dart';
import 'package:email_validator/email_validator.dart';

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
      body: Builder(
        builder: (context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          alignment: Alignment.center,   
          child: FractionallySizedBox(
            widthFactor: .7,
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
                  validator: (val) => EmailValidator.validate(val) == false ? "Enter a valid email" : null,
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
                SizedBox(height: 40.0),
                RaisedButton(
                  child: Text("Register now", style: Styles.smallBold),
                  onPressed: () async {
                    // Check validation
                    if (_formKey.currentState.validate()) {
                      dynamic result = await AuthService.register(
                          _username, _email, _password);

                      // Error catch
                      if (result == null || result.uid == null) {
                        _showSnackbar(context, 'Registration Error', Styles.errorBold);
                      } else {
                        //show registered dialogue
                        // Create new storage area for user in database
                        User.initDBEntry(result.uid, _username, _email);

                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.popUntil(
                            context, ModalRoute.withName('/'));
                        });
                        
                        _showSnackbar(context, 'Registering...', Styles.smallBold);
                        
                        await AuthService.signOut();
                      }
                    }
                  }
                ),       
              ])
            ),
          )
        ),
      )
    );
  }
  void _showSnackbar(BuildContext context, String text, TextStyle style) {
    final snackbar = SnackBar(
      content: Text(text, style: style),
      backgroundColor: Colors.grey[900]
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
