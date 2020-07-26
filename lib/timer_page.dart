import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:pomodoro/components/build_drawer.dart';
import 'package:pomodoro/components/app_bar.dart';
import 'package:pomodoro/models/user.dart';

class TimerPage extends StatefulWidget {
  User user;

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  //this.widget.user = ModalRoute.of(context).settings.arguments;
  //User user = this.widget.user;
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
  }

  @override
  Widget build(BuildContext context) {
    this.widget.user = ModalRoute.of(context).settings.arguments;
    User user = this.widget.user;

    return Scaffold(
        appBar: CustomAppBar('Timer', user),
        drawer: BuildDrawer(user),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
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
                                        }))
                              ],
                            )))),
                Align(),
              ],
            )));
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
