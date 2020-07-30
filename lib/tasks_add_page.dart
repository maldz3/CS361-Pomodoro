import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'package:pomodoro/models/user.dart';
import 'package:pomodoro/models/task.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:pomodoro/models/task_dto.dart';

class TaskAddPageArgs {
  User user;
  Task task;
  TaskAddPageArgs(this.user, {Task task}) : task = task;
}

//New Task Entry form
class TasksAddPage extends StatefulWidget {
//  User user;
//  Task taskToEdit;
//
//  TasksAddPage(TaskAddPageArgs args): user = args.user, taskToEdit = args.task;

  _TasksAddPageState createState() => _TasksAddPageState();
}

class _TasksAddPageState extends State<TasksAddPage> {
  final formKey = GlobalKey<FormState>();
  TaskDTO taskInfo = TaskDTO();

  @override
  Widget build(BuildContext context) {
    TaskAddPageArgs args = ModalRoute.of(context).settings.arguments;
    User user = args.user;
    Task taskToEdit = args.task;

    String title = 'Add a Task';
    if (taskToEdit != null) {
      title = 'Edit Task';
      taskInfo.category = taskToEdit.category;
      taskInfo.id = taskToEdit.id;
    }
    return Scaffold(
        appBar: CustomAppBar(title, user),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: formKey,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                            initialValue:
                                (taskToEdit == null) ? null : taskToEdit.name,
                            autofocus: true,
                            decoration: InputDecoration(
                                labelText: 'Task Name',
                                border: OutlineInputBorder()),
                            onSaved: (value) {
                              taskInfo.name = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a task name';
                              } else {
                                return null;
                              }
                            }),
                        SizedBox(height: 8),
                        TextFormField(
                            initialValue: (taskToEdit == null)
                                ? null
                                : taskToEdit.description,
                            autofocus: true,
                            decoration: InputDecoration(
                                labelText: 'Description',
                                border: OutlineInputBorder()),
                            onSaved: (value) {
                              taskInfo.description = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a description';
                              } else {
                                return null;
                              }
                            }),
                        SizedBox(height: 8),
                        TextFormField(
                            initialValue: (taskToEdit == null)
                                ? null
                                : taskToEdit.durationWork.toString(),
                            autofocus: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                labelText: 'Task Duration (Minutes)',
                                border: OutlineInputBorder()),
                            onSaved: (value) {
                              taskInfo.durationWork = int.tryParse(value);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a task duration';
                              } else {
                                return null;
                              }
                            }),
                        SizedBox(height: 8),
                        TextFormField(
                            initialValue: (taskToEdit == null)
                                ? null
                                : taskToEdit.durationBreak.toString(),
                            autofocus: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                labelText: 'Break Duration (Minutes)',
                                border: OutlineInputBorder()),
                            onSaved: (value) {
                              taskInfo.durationBreak = int.tryParse(value);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a break duration';
                              } else {
                                return null;
                              }
                            }),
                        SizedBox(height: 8),
                        TextFormField(
                            initialValue: (taskToEdit == null)
                                ? null
                                : taskToEdit.goalTime.toString(),
                            autofocus: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                labelText: 'Goal Time (Minutes)',
                                border: OutlineInputBorder()),
                            onSaved: (value) {
                              taskInfo.goalTime = int.tryParse(value);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a goal time';
                              } else {
                                return null;
                              }
                            }),
                        SizedBox(height: 8),
                        DropDownFormField(
                          titleText: 'Category',
                          hintText: 'Please choose one',
                          value: taskInfo.category,
                          onSaved: (value) {
                            setState(() {
                              taskInfo.category = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a category';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              taskInfo.category = value;
                            });
                          },
                          dataSource: user.tasks.categories,
                          textField: 'id',
                          valueField: 'value',
                        ),
                        SizedBox(height: 20.0),
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
                                      Task newTask = Task(
                                          id: taskInfo.id,
                                          name: taskInfo.name,
                                          description: taskInfo.description,
                                          durationWork: taskInfo.durationWork,
                                          durationBreak: taskInfo.durationBreak,
                                          goalTime: taskInfo.goalTime,
                                          category: taskInfo.category);

                                      await user.tasks.add(newTask);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text('SaveEntry'))
                            ])
                      ]),
                )))));
  }
}
