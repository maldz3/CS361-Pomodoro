import 'package:flutter/material.dart';
import 'app.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

const String title = 'Pomodoro';
void main() {
  runApp(Phoenix(child:App(title: title)));
}
