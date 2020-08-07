import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'app.dart';

const String title = 'Pomodoro';
void main() {
  runApp(Phoenix(child:App(title: title)));
}
