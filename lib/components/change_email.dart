import 'package:flutter/material.dart';
import 'package:pomodoro/models/user.dart';

// void changeEmail(BuildContext context, User curUser) {

//     final myController = TextEditingController();

//     Navigator.push(context, MaterialPageRoute<void>(
//       builder: (BuildContext context) {
//         return Scaffold(
//           appBar: AppBar(title: Text('Update Email')),
//           body: Center(
//               child: Column(children: [
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//               Text('Please enter a new email: '),
//               Expanded(
//                   child: TextField(
//                       controller: myController,
//                       decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Enter email Here')))
//             ]),
//             Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//               FlatButton(
//                 color: Colors.blueGrey,
//                 textColor: Colors.white,
//                 splashColor: Colors.blueAccent,
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('Don\'t Change'),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               Padding(padding: EdgeInsets.all(8)),
//               FlatButton(
//                   color: Colors.blueGrey,
//                   textColor: Colors.white,
//                   splashColor: Colors.blueAccent,
//                   padding: EdgeInsets.all(8.0),
//                   child: Text('Save'),
//                   onPressed: () => setState(
//                         () {
//                           var newUserName = myController.text;
//                           if (newUserName != '') {
//                             curUser.changeName(newUserName);
//                             Navigator.pop(context);
//                           } else {
//                             showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                       content:
//                                           Text('Username cannot be blank.'),
//                                       actions: <Widget>[
//                                         FlatButton(
//                                             child: Text('Close'),
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             })
//                                       ]);
//                                 });
//                           }
//                         },
//                       ))
//             ])
//           ])),
//         );
//       },
//     ));
//   }