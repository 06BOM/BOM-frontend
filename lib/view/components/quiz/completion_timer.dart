import 'package:flutter/material.dart';
import 'dart:math' as math;

class QuizCompletionTimer extends StatelessWidget {
  final double progress;
  const QuizCompletionTimer({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: timerBorderPaint(progress: progress, taskCompletedColor: progress < 0.5 ? Colors.yellow : Colors.red, taskNotCompletedColor: Colors.black),
    );
  }
}

class timerBorderPaint extends CustomPainter {
  // timerBorderPaint(
  //     this.progress, this.taskNotCompletedColor, this.taskCompletedColor);
  timerBorderPaint(
      {required this.progress, required this.taskNotCompletedColor, required this.taskCompletedColor}); // required for named parameter

  final double progress;
  final Color taskNotCompletedColor;
  final Color taskCompletedColor;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 15.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2.7; // 2일때 꽉 찬다.

    final backgroundpaint = Paint()
      ..isAntiAlias = true
      ..color = taskNotCompletedColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke; //important set stroke style

    canvas.drawCircle(center, radius, backgroundpaint);

    final foregraoundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth
      ..color = taskCompletedColor
      ..style = PaintingStyle.stroke;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, 2 * math.pi * progress, false, foregraoundPaint);
  }

  @override
  bool shouldRepaint(covariant timerBorderPaint oldDelegate) => oldDelegate.progress != progress;
}

class AnimatedTask extends StatefulWidget {
  const AnimatedTask({Key? key}) : super(key: key);

  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask> with SingleTickerProviderStateMixin{
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 7500));
    super.initState();
    _animationController.forward();
    // _animationController.reverse(); // 반대
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _animationController, builder: (BuildContext context, Widget? child){
      return QuizCompletionTimer(progress: _animationController.value);
    });
  }
}