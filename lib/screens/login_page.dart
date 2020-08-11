import 'package:flutter/material.dart';
import 'package:pomodoro/styles.dart';
import 'package:pomodoro/services/auth.dart';
import 'package:email_validator/email_validator.dart';

// Sign in page

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  // Hold form data
  String _email = "";
  String _password = "";
  String _passResetEmail = "";

  final _formKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("ScrumBags Pomodoro"),
            elevation: 0.0),
        body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              child: FractionallySizedBox(
                widthFactor: .6,
                child: Column(children: [
                  loginForm(),
                  SizedBox(height: 20.0),
                  createAccountButton(),
                  SizedBox(height: 20.0),
                  forgotPasswordButton(),
                ]),
              )),
        ));
  }

  Widget loginForm() {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
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
          // Login button
          SizedBox(height: 20.0),
          RaisedButton(
              child: Text("Log in", style: Styles.smallBold),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  dynamic result = await AuthService.signIn(_email, _password);
                  if (result == null) {
                    _displaySnackBar(
                        context, 'Invalid Login Credentials', Styles.errorBold);
                  }
                }
              })
        ]));
  }

  Widget createAccountButton() {
    return InkWell(
        child: Text("Create Account", style: Styles.smallBold),
        onTap: () {
          Navigator.pushNamed(context, 'register');
        });
  }

  Widget forgotPasswordButton() {
    return InkWell(
        child:
            Text("Forgot your password?  Click here.", style: Styles.smallBold),
        onTap: () async {
          return showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return passwordResetDialog();
              });
        });
  }

  Widget passwordResetDialog() {
    return AlertDialog(
      title: Text('Send Password Reset E-mail'),
      content: Form(
          key: _passwordKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(
                decoration: InputDecoration(hintText: "Email"),
                validator: (val) => val.isEmpty ? "Enter an email" : null,
                onChanged: (val) {
                  setState(() => _passResetEmail = val);
                }),
          ])),
      actions: [
        RaisedButton(
            child: Text("Send", style: Styles.smallBold),
            onPressed: () {
              if (_passwordKey.currentState.validate()) {
                AuthService.resetPassword(_passResetEmail);
                Navigator.pop(context);
                _displaySnackBar(
                    context, 'Password Reset E-mail Sent', Styles.smallBold);
              }
            }),
      ],
    );
  }

  void _displaySnackBar(BuildContext context, String text, TextStyle style) {
    final snackbar = SnackBar(
        content: Text(text, style: style), backgroundColor: Colors.grey[900]);
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
