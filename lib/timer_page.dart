import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:pomodoro/our_models.dart';
import 'package:pomodoro/widgets/auto_size_text.dart';

class TimerPage extends StatefulWidget {
  final Task task;

  TimerPage({this.task});

  @override
  _TimerPageState createState() => _TimerPageState();
}

//Code based on: https://www.youtube.com/watch?v=tRe8teyf9Nk&feature=youtu.be
class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  User user;
  Task task;
  bool breakTime;
  String taskType;

  int accumulatedSeconds;
  Timer _everySecondTimer;
  int segmentTime;

  @override
  void initState() {
    super.initState();

    user = User.getInstance();
    task = this.widget.task;

    breakTime = true; // transition will toggle, so this will start with work.
    transition();
  }

  @override
  void dispose() {
    _everySecondTimer.cancel();
    super.dispose();
  }

  String get timerString {
    int delta = segmentTime - accumulatedSeconds;
    String minutes = (delta ~/ 60).toString();
    String seconds = (delta % 60).toString();
    if (seconds.length == 1)
      seconds = '0' + seconds;
    return minutes + ":" + seconds;
  }

  void start() {
    _everySecondTimer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        accumulatedSeconds++;
        int delta = segmentTime - accumulatedSeconds;
        if (delta <= 0) {
          transition();
        }
      });
    });
  }

  void pause() {
    _everySecondTimer.cancel();
  }

  void transition() {
    breakTime = !breakTime;

    if (breakTime == false) {
      taskType = 'Work';
      segmentTime = task.durationWork * 60;
    } else {
      taskType = 'Break';
      segmentTime = task.durationBreak * 60;
    }

    accumulatedSeconds = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
              '${task.name} - $taskType    Current total completed: ${task.totalTime}')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          timer(context),
          SizedBox(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                playPauseButton(context),
                stopButton(context),
              ]),
          SizedBox(height: 10),
          skipButton(context),
        ]),
      ),
    );
  }

  Widget timer(BuildContext context) {
    return Expanded(
              child: Align(
                  alignment: FractionalOffset.center,
                  child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Stack(
                        children: <Widget>[
                          // ColorFiltered(
                          //   colorFilter: ColorFilter.mode(Colors.green, BlendMode.modulate),
                          //     child: Image.asset('assets/images/tomato2'),
                          // ),

                          Align(
                            alignment: FractionalOffset.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                AutoSizeText(
                                  'Time Remaining',
                                  style: TextStyle(fontSize: 36),
                                  maxLines: 1,
                                ),
                                AutoSizeText(
                                        timerString,
                                        style: TextStyle(fontSize: 100),
                                        maxLines: 1,
                                      ),
                              ],
                            ),
                          )
                        ],
                      ))));
  }

  Widget playPauseButton(BuildContext context) {
    return FloatingActionButton(
                  backgroundColor: Colors.green,
                  child: Row(children: [
                          Icon(Icons.play_arrow),
                          Text('/'),
                          Icon(Icons.pause)
                        ]),
                  onPressed: () {
                    if (_everySecondTimer != null && _everySecondTimer.isActive) {
                      pause();
                    } else {
                      start();
                    }
                  },
                );
  }

  Widget stopButton(BuildContext context) {
    return RaisedButton(
                    child: Icon(Icons.stop),
                    color: Colors.red,
                    onPressed: () {
                      updateTotalTime();
                      _everySecondTimer.cancel();
                      Navigator.of(context).pop();
                    });
  }

  Widget skipButton(BuildContext context) {
    return RaisedButton(
              child: Text('Skip to next'),
              onPressed: () {
                setState(() {
                  updateTotalTime();
                  transition();
                });
              });
  }

  void updateTotalTime() {
    if (breakTime == true) {
      return;
    } else {
      task.addTime(accumulatedSeconds);
      user.tasks.update(task); // assuming task retains key, this will update the task with the new total.
    }
  }
}