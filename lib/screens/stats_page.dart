import 'package:flutter/material.dart';
import 'package:pomodoro/our_components.dart';
import 'package:pomodoro/our_models.dart';

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar('Stats'),
        drawer: BuildDrawer(),
        body: Builder(builder: (context) {
          return SingleChildScrollView();
        }));
  }
}
