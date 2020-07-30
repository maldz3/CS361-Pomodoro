import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:pomodoro/components/build_drawer.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'package:pomodoro/models/user.dart';
import 'package:pomodoro/models/task.dart';

class TimerPage extends StatefulWidget {
  User user;
  Task task;

  TimerPage({this.user, this.task});

  @override
  _TimerPageState createState() => _TimerPageState();
}

//Code based on: https://www.youtube.com/watch?v=tRe8teyf9Nk&feature=youtu.be
class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
        duration: Duration(minutes: this.widget.task.durationWork));
  }

  @override
  Widget build(BuildContext context) {
    Task task = this.widget.task;
    User user = this.widget.user;

    return Scaffold(
        appBar: CustomAppBar('Timer', user),
        drawer: BuildDrawer(user),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('${task.name}', style: TextStyle(fontSize: 60)),
                  Column(children: <Widget>[
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
                                            builder: (BuildContext context,
                                                Widget child) {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text('Time Remaining',
                                              style: TextStyle(fontSize: 18)),
                                          AnimatedBuilder(
                                              animation: controller,
                                              builder: (BuildContext context,
                                                  Widget child) {
                                                return Text(timerString,
                                                    style: TextStyle(
                                                        fontSize: 100));
                                              })
                                        ],
                                      ),
                                    )
                                  ],
                                )))),
                    Container(
                        margin: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FloatingActionButton(
                              child: AnimatedBuilder(
                                  animation: controller,
                                  builder:
                                      (BuildContext context, Widget child) {
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
                                      from: controller.value == 0.0
                                          ? 1.0
                                          : controller.value);
                                }
                              },
                            )
                          ],
                        ))
                  ]),
                  SizedBox(width: 20),
                  Text('Placeholder'),
                ])));
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
