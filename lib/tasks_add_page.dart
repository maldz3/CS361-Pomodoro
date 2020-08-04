import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro/our_components.dart';
import 'package:pomodoro/our_models.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class TaskAddPageArgs {
  Task task;
  TaskAddPageArgs({Task task}) : task = task;
}

//New Task Entry form
class TasksAddPage extends StatefulWidget {
  _TasksAddPageState createState() => _TasksAddPageState();
}

class _TasksAddPageState extends State<TasksAddPage> {
  User user;
  final formKey = GlobalKey<FormState>();
  String title = 'Edit a Task';
  TaskDTO taskInfo = TaskDTO();

  @override
  void initState() {
    super.initState();

    user = User.getInstance();
    // couldn't do the taskinfo setting here because not
    // allowed to do the ModalRoute.of here for fuck sake.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    TaskAddPageArgs args = ModalRoute.of(context).settings.arguments;
    Task taskToEdit = args.task;

    if (taskToEdit != null) {
      title = 'Edit Task';
      taskInfo.category = taskToEdit.category;
      taskInfo.id = taskToEdit.id;
      taskInfo.goalTime = taskToEdit.goalTime;
      taskInfo.durationBreak = taskToEdit.durationBreak;
      taskInfo.durationWork = taskToEdit.durationWork;
      taskInfo.description = taskToEdit.description;
      taskInfo.name = taskToEdit.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title),
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
                            initialValue: taskInfo.name,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
                            initialValue: taskInfo.description,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
                            initialValue: (taskInfo.durationWork == null)
                                ? null
                                : taskInfo.durationWork.toString(),
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                            inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly
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
                            initialValue: (taskInfo.durationBreak == null)
                                ? null
                                : taskInfo.durationBreak.toString(),
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                            inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly
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
                            initialValue: (taskInfo.goalTime == null)
                                ? null
                                : taskInfo.goalTime.toString(),
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                            inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly
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
