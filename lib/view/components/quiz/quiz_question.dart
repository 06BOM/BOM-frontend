import 'package:bom_front/model/question.dart';
import 'package:bom_front/provider/quiz/quiz_provider.dart';
import 'package:bom_front/provider/quiz/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'dart:math' as math;
import 'answer_card.dart';

class QuizQuestions extends ConsumerWidget {
  final PageController pageController;
  final QuizState state;
  final List<Question> questions;

  QuizQuestions({
    Key? key,
    required this.pageController,
    required this.state,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(), // ??????
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          final question = questions[index];
          return Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                color: Colors.black.withOpacity(0.2),
                margin: const EdgeInsets.only(
                  top: 80.0,
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Q ${index + 1} / ${questions.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      width: MediaQuery.of(context).size.width - 2.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                HtmlCharacterEntities.decode(question.question),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Divider(
              //   color: Colors.grey[200],
              //   height: 32.0,
              //   thickness: 2.0,
              //   indent: 20.0,
              //   endIndent: 20.0,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // padding: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.greenAccent, width: 2)),
                    width: 80.0,
                    height: 80.0,
                    child: CustomPaint(
                      painter: timerBorderPaint(progress: 0.6, taskCompletedColor: Colors.blue, taskNotCompletedColor: Colors.white),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    // padding: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.greenAccent, width: 2)),
                    width: 180.0,
                    height: 180.0,
                    child: CustomPaint(
                      painter: CrossDrawPaint(),
                      child: Container(),
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.greenAccent, width: 2)),
                    width: 180.0,
                    height: 180.0,
                    child: CustomPaint(
                      painter: RingPaint(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: question.answers
                    .map((e) => AnswerCard(
                        answer: e,
                        isSelected: e == state.selectedAnswer,
                        isCorrect: e == question.correctAnswer,
                        isDisplayingAnswer: state.answered,
                        onTap: () => ref
                            .read(quizControllerProvider.notifier)
                            .submitAnswer(question, e)))
                    .toList(),
              ),
            ],
          );
        });
  }
}

class CrossDrawPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint crossBrush = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;
    canvas.drawLine(const Offset(40, 40),
        Offset(size.width - 40, size.height - 40), crossBrush);
    canvas.drawLine(
        Offset(size.width - 40, 40), Offset(40, size.height - 40), crossBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RingPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 5.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2.7; // 2일때 꽉 찬다.

    final backgroundpaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke; //important set stroke style

    canvas.drawCircle(center, radius, backgroundpaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class timerBorderPaint extends CustomPainter {
  // timerBorderPaint(
  //     this.progress, this.taskNotCompletedColor, this.taskCompletedColor);
  timerBorderPaint(
      {required this.progress, required this.taskNotCompletedColor, required this.taskCompletedColor});

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
