import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'dart:developer'; // for debug printing with "log"
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro/components/build_drawer.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'package:pomodoro/models/task.dart';
import 'package:pomodoro/models/user.dart';

class TasksPage extends StatelessWidget {
  final User user;
  final BuildDrawer buildDrawer;
  TasksPage(this.user, this.buildDrawer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar('Timer'),
        drawer: buildDrawer,
        body: Container (
            child: new ListView.builder(
              itemCount: user.tasks.length,
              itemBuilder: (BuildContext context, int index) => buildTaskCard(context, index),
            ),
          )
        );
  }

  Widget buildTaskCard(BuildContext context, int index) {
    return Container(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Text(index.toString()),
                      Text(user.tasks.list[index].name),
                    ],
                  ),
                ),
              );
  }
}