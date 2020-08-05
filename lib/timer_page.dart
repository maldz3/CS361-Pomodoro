import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:pomodoro/our_models.dart';

class TimerPage extends StatefulWidget {
  Task task;
  bool breakTime;

  TimerPage({this.task, this.breakTime});

  @override
  _TimerPageState createState() => _TimerPageState();
}

//Code based on: https://www.youtube.com/watch?v=tRe8teyf9Nk&feature=youtu.be
class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  User user;
  AnimationController controller;
  String taskType;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  int pickWorkorBreak() {
    if (this.widget.breakTime == false) {
      taskType = 'Work';
      return this.widget.task.durationWork;
    } else {
      taskType = 'Break';
      return this.widget.task.durationBreak;
    }
  }

  @override
  void initState() {
    super.initState();
    user = User.getInstance();
    int _time = pickWorkorBreak();
    controller =
        AnimationController(vsync: this, duration: Duration(minutes: _time));
  }

  @override
  Widget build(BuildContext context) {
    Task task = this.widget.task;

    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              child: Icon(Icons.home),
              onTap: () {
                updateTotalTime();
                Navigator.of(context).pop();
              }),
          centerTitle: true,
          title: Text(
              '${task.name} - $taskType    Current total completed: ${task.totalTime}')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          Expanded(
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
                      )))),
          SizedBox(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
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
                ),
                RaisedButton(
                    child: Icon(Icons.stop),
                    color: Colors.red,
                    onPressed: () {
                      updateTotalTime();
                      Navigator.of(context).pop();
                    })
              ]),
          SizedBox(height: 10),
          RaisedButton(
              child: Text('Skip to next'),
              onPressed: () {
                updateTotalTime();
                this.widget.breakTime = !this.widget.breakTime;
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => TimerPage(
                            task: task, breakTime: this.widget.breakTime)),
                    ModalRoute.withName('/'));
              }),
        ]),
      ),
    );
  }

  void updateTotalTime() {
    if (this.widget.breakTime == true) {
      return;
    } else {
      Duration _duration = controller.duration * controller.value;
      int _completed = this.widget.task.durationWork - _duration.inMinutes;
      this.widget.task.addTime(_completed);
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
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
