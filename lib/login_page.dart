import 'package:flutter/material.dart';
import 'package:pomodoro/styles.dart';
import 'services/auth.dart';

// Sign in page

class LogIn extends StatefulWidget {
  final Function refreshHomePage;

  LogIn(this.refreshHomePage);

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
            child: Column(
              children: [
                loginForm(),
                SizedBox(height: 20.0),
                createAccountButton(),
                SizedBox(height: 20.0),
                forgotPasswordButton(),
                SizedBox(height: 20.0),
                errorText()
              ]
            ),
          )
        ),
      )
    );
  }

  Widget loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Email box
          SizedBox(height: 20.0),
          TextFormField(
            decoration: InputDecoration(hintText: "Email"),
            validator: (val) => val.isEmpty ? "Enter an email" : null,
            onChanged: (val) {
              setState(() => _email = val);
            }
          ),
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
            }
          ),
          // Login button
          SizedBox(height: 20.0),
          RaisedButton(
            child: Text("Log in", style: Styles.smallBold),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                dynamic result = await _auth.signIn(_email, _password);
                if (result == null) setState(() => _error = "Invalid credentials");
                else this.widget.refreshHomePage(); 
              }
            }
          )
        ]
      )
    );
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
      child: Text("Forgot your password?  Click here.", style: Styles.smallBold),
      onTap: () async {
        return showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return passwordResetDialog();
          }
        );
      }
    );
  }

  Widget passwordResetDialog() {
    return AlertDialog(
      title: Text('Send Password Reset E-mail'),
      content: Form(
        key: _passwordKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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

  Widget errorText() {
    return Text(
      _error,
      style: TextStyle(color: Colors.red, fontSize: 20),
    );
  }
}
