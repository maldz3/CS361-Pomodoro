import 'package:flutter/material.dart';
import 'package:pomodoro/our_models.dart';
import 'package:pomodoro/our_components.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pomodoro/styles.dart';

class AccountPage extends StatefulWidget {
  User user;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final userKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  var userAutoValidate = false;
  var emailAutoValidate = false;
  var passwordAutoValidate = false;

  @override
  Widget build(BuildContext context) {
    this.widget.user = ModalRoute.of(context).settings.arguments;
    var username = this.widget.user.username;
    var email = this.widget.user.email;
    return Scaffold(
        appBar: CustomAppBar('Account Settings', widget.user),
        drawer: BuildDrawer(widget.user),
        body: Builder(
          builder: (context) {
            return Container(
              child: Column(
                children: [
                  accountInfoHeader(username, email),
                  usernameUpdateRow(context, username),
                  emailUpdateRow(context, email),
                  passwordUpdateRow(context),
                  accountResetRow(context)
                ]
            ),
          );
        })
    );
  }

  Widget accountInfoHeader(String username, String email) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.blueGrey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          headerColumn('User Name', '$username'),
          headerColumn('Email', '$email')
      ]),
    );
  }

  Widget headerColumn(String heading, String value) {
    return Column(
      children: [
        smallHeader(context, heading),
        sortaBigText(context, value)
      ]
    );
  }

  Widget usernameUpdateRow(BuildContext context, String username) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: FractionallySizedBox(
        widthFactor: .6,
        child: Form(
          key: userKey,
          autovalidate: userAutoValidate,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: "New Username", 
                    border: OutlineInputBorder(),
                    counterText: ""
                  ),
                  onSaved: (value) async {
                    bool result = await this.widget.user.changeName(value);
                    if (result == true){
                      setState(() {
                        username = value;
                      });
                      _showSnackbar(context, 'Username Updated');
                    } else {
                      _showSnackbar(context, 'Username Update Failed');
                    }
                    //store it
                  },
                  validator: (value) => value.isEmpty ? "Enter a new username" : null
                ),
              ),
              SizedBox(width: 20),
              updateButton(userKey, 'username')
            ],
          ),
        ),
      ),
    );
  }

  Widget emailUpdateRow(BuildContext context, String email) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: FractionallySizedBox(
        widthFactor: .6,
        child: Form(
          key: emailKey,
          autovalidate: emailAutoValidate,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  maxLength: 30,
                    decoration: InputDecoration(
                      labelText: "New Email", 
                      border: OutlineInputBorder(),
                      counterText: ""
                    ),
                    onSaved: (value) async {
                      bool result = await this.widget.user.changeEmail(value);
                      if (result == true) {
                        setState(() {
                          email = value;
                        });
                        _showSnackbar(context, 'Email Updated');
                      } else {
                        _showSnackbar(context, 'Email Update Failed');
                      } 
                    },
                    validator: (value) => 
                      !EmailValidator.validate(value) ? "Enter a valid email" : null
                  ),
                ),
                SizedBox(width: 20),
                updateButton(emailKey, 'email')
            ],
          )
        ),
      ),
    );
  }

  Widget passwordUpdateRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: FractionallySizedBox(
        widthFactor: .6,
        child: Form(
          key: passwordKey,
          autovalidate: passwordAutoValidate,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  maxLength: 30,
                  obscureText: true,
                    decoration: InputDecoration(
                      labelText: "New Password", 
                      border: OutlineInputBorder(),
                      counterText: ""
                    ),
                    onSaved: (value) async {
                      bool result = await this.widget.user.changePassword(value);
                      if (result == true) {
                        _showSnackbar(context, 'Password Updated');
                      } else {
                        _showSnackbar(context, 'Password Update Failed');
                      } 
                    },
                    validator: (value) => 
                      value.length < 6 ? "Enter a valid password" : null
                  ),
                ),
                SizedBox(width: 20),
                updateButton(passwordKey, 'password')
            ],
          )
        ),
      ),
    );
  }

  Widget updateButton(GlobalKey<FormState> key, String type) {
    return RaisedButton(
      onPressed: () {
        if (key.currentState.validate()) {
          key.currentState.save();
          key.currentState.reset();
          if (type == 'email') emailAutoValidate = false;
          else if (type == 'username') userAutoValidate = false;
          else passwordAutoValidate = false;
        } else {
          setState(() {
            if (type == 'email') emailAutoValidate = true;
            else if (type == 'username') userAutoValidate = true;
            else passwordAutoValidate = true;
          }); 
        }
      },
      child: Text('Update')
    );
  }

  Widget accountResetRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: RaisedButton(
        color: Colors.red,
        onPressed: () {print("Button Pressed");},
        child: Text('Reset Account'),
      )
    );
  }

  void _showSnackbar(BuildContext context, String text) {
    final snackbar = SnackBar(content: Text(text));
    Scaffold.of(context).showSnackBar(snackbar);

  }
}