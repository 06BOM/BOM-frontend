import 'package:bom_front/model/question.dart';
import 'package:bom_front/provider/quiz/quiz_provider.dart';
import 'package:bom_front/provider/quiz/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'answer_card.dart';
import 'completion_timer.dart';

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
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 70.0,
                    height: 70.0,
                    child: CustomPaint(
                      painter: circleDrawPaint(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // padding: EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.greenAccent, width: 2)),
                        width: 80.0,
                        height: 80.0,
                        child: AnimatedTask(),
                      ),
                    ],
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Container(
              //       // padding: EdgeInsets.all(0.0),
              //       decoration: BoxDecoration(
              //           border:
              //               Border.all(color: Colors.greenAccent, width: 2)),
              //       width: 180.0,
              //       height: 180.0,
              //       child: CustomPaint(
              //         painter: CrossDrawPaint(),
              //         child: Container(),
              //       ),
              //     ),
              //     Container(
              //       // padding: EdgeInsets.all(0.0),
              //       decoration: BoxDecoration(
              //           border:
              //               Border.all(color: Colors.greenAccent, width: 2)),
              //       width: 180.0,
              //       height: 180.0,
              //       child: CustomPaint(
              //         painter: RingPaint(),
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => {print('O touch')},
                    child: Container(
                      child: Center(
                        child: Text(
                          'O',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 100,
                              shadows: [
                                Shadow(
                                  blurRadius: 40,
                                  color: Colors.blue,
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {print('X touch')},
                    child: Container(
                      child: Center(
                        child: Text(
                          'X',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 100,
                              shadows: [
                                Shadow(
                                  blurRadius: 40,
                                  color: Colors.red,
                                ),
                              ]),
                        ),
                      ),
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

class circleDrawPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 15.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2.7;

    Paint brush = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, brush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

// class CrossDrawPaint extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint crossBrush = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 30;
//     canvas.drawLine(const Offset(40, 40),
//         Offset(size.width - 40, size.height - 40), crossBrush);
//     canvas.drawLine(
//         Offset(size.width - 40, 40), Offset(40, size.height - 40), crossBrush);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
//
// class RingPaint extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final strokeWidth = size.width / 5.0;
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = (size.width - strokeWidth) / 2.7; // 2일때 꽉 찬다.
//
//     final backgroundpaint = Paint()
//       ..color = Colors.blue
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke; //important set stroke style
//
//     canvas.drawCircle(center, radius, backgroundpaint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
