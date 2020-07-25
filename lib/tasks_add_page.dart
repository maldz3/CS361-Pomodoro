import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'package:pomodoro/models/user.dart';
import 'package:pomodoro/models/task.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:pomodoro/models/task_dto.dart';

//New Task Entry form
class TasksAddPage extends StatefulWidget {
  User user;

  _TasksAddPageState createState() => _TasksAddPageState();
}

class _TasksAddPageState extends State<TasksAddPage> {
  final formKey = GlobalKey<FormState>();
  TaskDTO newTask = TaskDTO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar('Add a Task', this.widget.user),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: formKey,
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      TextFormField(
                          autofocus: true,
                          decoration: InputDecoration(
                              labelText: 'Task Name',
                              border: OutlineInputBorder()),
                          onSaved: (value) {
                            newTask.name = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a task name';
                            } else {
                              return null;
                            }
                          }),
                      TextFormField(
                          autofocus: true,
                          decoration: InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder()),
                          onSaved: (value) {
                            newTask.description = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a description';
                            } else {
                              return null;
                            }
                          }),
                      TextFormField(
                          autofocus: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              labelText: 'Task Duration (Minutes)',
                              border: OutlineInputBorder()),
                          onSaved: (value) {
                            newTask.durationWork = int.tryParse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a task duration';
                            } else {
                              return null;
                            }
                          }),
                      TextFormField(
                          autofocus: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              labelText: 'Break Duration (Minutes)',
                              border: OutlineInputBorder()),
                          onSaved: (value) {
                            newTask.durationBreak = int.tryParse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a break duration';
                            } else {
                              return null;
                            }
                          }),
                      TextFormField(
                          autofocus: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              labelText: 'Goal Time (Minutes)',
                              border: OutlineInputBorder()),
                          onSaved: (value) {
                            newTask.goalTime = int.tryParse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a goal time';
                            } else {
                              return null;
                            }
                          }),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: DropDownFormField(
                          titleText: 'Category',
                          hintText: 'Please choose one',
                          value: newTask.category,
                          onSaved: (value) {
                            setState(() {
                              newTask.category = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please select a category';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              newTask.category = value;
                            });
                          },
                          dataSource: [
                            {'display': 'School', 'value': 'School'},
                            {'display': 'Work', 'value': 'Work'},
                            {'display': 'Exercise', 'value': 'Exercise'},
                            {'display': 'Home', 'value': 'Home'},
                            {'display': 'Family', 'value': 'Family'},
                            {'display': 'Other', 'value': 'Other'}
                          ],
                          textField: 'display',
                          valueField: 'value',
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel')),
                            RaisedButton(
                                color: Colors.red,
                                onPressed: () async {
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();
                                    this.widget.user = ModalRoute.of(context)
                                        .settings
                                        .arguments;
                                    User user = this.widget.user;
                                    Task addTask = Task(
                                        name: newTask.name,
                                        description: newTask.description,
                                        durationWork: newTask.durationWork,
                                        durationBreak: newTask.durationBreak,
                                        goalTime: newTask.goalTime,
                                        category: newTask.category);

                                    user.tasks.add(addTask);
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text('SaveEntry'))
                          ])
                    ])))));
  }
}
