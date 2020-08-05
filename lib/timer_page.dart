import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:pomodoro/our_models.dart';

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
  AnimationController controller;
  String taskType;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  int pickWorkorBreak() {
    if (breakTime == false) {
      taskType = 'Work';
      return task.durationWork;
    } else {
      taskType = 'Break';
      return task.durationBreak;
    }
  }

  @override
  void initState() {
    super.initState();
    user = User.getInstance();
    task = this.widget.task;
    breakTime = false;

    int _time = pickWorkorBreak();
    controller =
        AnimationController(vsync: this, duration: Duration(minutes: _time));
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
                          Positioned.fill(
                              child: AnimatedBuilder(
                                  animation: controller,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return CustomPaint(
                                        painter: TimerPainter(
                                      animation: controller,
                                      backgroundColor: Colors.blue,
                                      color: Colors.yellowAccent,
                                    ));
                                  })),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Time Remaining',
                                    style: TextStyle(fontSize: 18)),
                                AnimatedBuilder(
                                    animation: controller,
                                    builder:
                                        (BuildContext context, Widget child) {
                                      return Text(timerString,
                                          style: TextStyle(fontSize: 100));
                                    })
                              ],
                            ),
                          )
                        ],
                      ))));
  }

  Widget playPauseButton(BuildContext context) {
    return FloatingActionButton(
                  backgroundColor: Colors.green,
                  child: AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        return new Row(children: [
                          Icon(Icons.play_arrow),
                          Text('/'),
                          Icon(Icons.pause)
                        ]);
                      }),
                  onPressed: () {
                    if (controller.isAnimating) {
                      controller.stop();
                    } else {
                      controller.reverse(
                          from:
                              controller.value == 0.0 ? 1.0 : controller.value);
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
                      Navigator.of(context).pop();
                    });
  }

  Widget skipButton(BuildContext context) {
    return RaisedButton(
              child: Text('Skip to next'),
              onPressed: () {
                setState(() {
                  updateTotalTime();
                  breakTime = !breakTime;
                });
              });
  }

  void updateTotalTime() {
    if (breakTime == true) {
      return;
    } else {
      Duration _duration = controller.duration * controller.value;
      int _completed = task.durationWork - _duration.inMinutes;
      if (_duration.inSeconds % 60 > 30) {
        _completed -= 1;
      }
      task.addTime(_completed);
      user.tasks.update(task); // assuming task retains key, this will update the task with the new total.
    }
  }
}

//Code based on: https://www.youtube.com/watch?v=tRe8teyf9Nk&feature=youtu.be
class TimerPainter extends CustomPainter {
  TimerPainter({this.animation, this.backgroundColor, this.color})
      : super(repaint: animation);
  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    var param1 = Offset.zero & size;
    var param2 = math.pi * 1.5;
    var param3 = -progress;
    print(param1);
    print(param2);
    print(param3);
    print(paint);
    canvas.drawArc(param1, param2, param3, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
