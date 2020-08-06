import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  bool blinker = true;

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
    if (seconds.length == 1) seconds = '0' + seconds;
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
    updateTotalTime();
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
          leading: GestureDetector(
              onTap: () {
                updateTotalTime();
                _everySecondTimer.cancel();
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back)),
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
    // don't delete this code!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // !! only compatible with mobile; ripening tomato animation
    // double modifier = accumulatedSeconds / segmentTime;
    // ColorFilter scaleColor = ColorFilter.matrix(<double>[
    // modifier, 0, 0, 0, 0,
    // 1-modifier, 1, modifier/2.0 - .5, modifier/2.0 - .5, 0,
    // 0, 0, 1, 0, 0,
    // 0, 0, 0, 1, 0,
    // ]);

    final timerChildren = List<Widget>();
    
    // don't delete this code!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // !! only compatible with mobile; ripening tomato animation
    // timerChildren.add(
    //   ColorFiltered(
    //     colorFilter: scaleColor, //ColorFilter.mode(Colors.green, BlendMode.hue),
    //       child: Image.asset('assets/images/tomato2_small.png'),
    //   )
    // );

    // add tomato
    timerChildren.add(
      Image.asset('assets/images/tomato2.png'), // plain asset must use large tomato to fill entire space.
    );

    // add caterpillars
    int numCaterpillars = (24.0 * ((segmentTime - accumulatedSeconds)/segmentTime)).round() + 1; // every 15 degrees
    double pi = 3.1415;
    double startAngle = pi/2;
    if (segmentTime > 60)
      blinker = !blinker;
    for (int i = 0; i < numCaterpillars; i++) {
      if (!((i == numCaterpillars - 1) && blinker)) {
        timerChildren.add(
          Transform.rotate(angle: startAngle - pi/12.0*i,
          child: Image.asset('assets/images/caterpillar_field.png')),
        );
      }
    }

    timerChildren.add(
      Transform.rotate(angle: pi/2,
      child: Image.asset('assets/images/caterpillar_field.png')),
    );

    timerChildren.add(
      Align(
        alignment: FractionalOffset.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AutoSizeText(
              'Time Remaining',
              style: TextStyle(fontSize: 36, color: Colors.white),
              maxLines: 1,
            ),
            AutoSizeText(
              timerString,
              style:
                  TextStyle(fontSize: 100, color: Colors.white),
              maxLines: 1,
            ),
          ],
        ),
      )
    );

    return Expanded(
      child: Align(
          alignment: FractionalOffset.center,
          child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: timerChildren,
                ),
              ),
            ),
          );
  }

  Widget playPauseButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green,
      child:
          Row(children: [Icon(Icons.play_arrow), Text('/'), Icon(Icons.pause)]),
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
            transition();
          });
        });
  }

  void updateTotalTime() {
    if (breakTime == true) {
      return;
    } else {
      int accomplished = (accumulatedSeconds / 60.0).round();
      if (accomplished > 0) {
        print('adding this many minutes to task time accomplished: ' + accomplished.toString());
        task.addTime(accomplished);
        user.tasks.update(task); // assuming task retains key, this will update the task with the new total.
      }
    }
  }
}
