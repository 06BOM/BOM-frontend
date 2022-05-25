import 'package:bom_front/model/question.dart';
import 'package:bom_front/provider/quiz/quiz_provider.dart';
import 'package:bom_front/provider/quiz/quiz_state.dart';
import 'package:bom_front/view/components/quiz/quiz_result.dart';
import 'package:bom_front/view/components/quiz/quiz_splash_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';
import '../../../utils/colors.dart';
import 'answer_card.dart';
import 'dart:math' as math;

class QuizQuestions extends ConsumerStatefulWidget {
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
  ConsumerState createState() => _QuizQuestionsState();
}

class _QuizQuestionsState extends ConsumerState<QuizQuestions> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _splashController; // for 준비 | 시작 term
  // late Animation<double> _nextPage;
  int _currentPage = 0;
  // bool isRoundFinish = false;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 10));
    // _nextPage = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _splashController = AnimationController(
      vsync: this, duration: Duration(seconds: 2));
    super.initState();
    // _animationController.forward();
    // _animationController.reverse(); // 반대

    _animationController.addListener(() async {
      if (_animationController.status == AnimationStatus.completed) {
        // print('라운드 끝 -> 다음 라운드');
        // isRoundFinish = true;
        // print('isRoundFinish ${isRoundFinish}');
        await Future.delayed(Duration(seconds: 3), (){
          _animationController.reset(); //Reset the controller
          // print('_currentPage => ${_currentPage}');
          if (_currentPage < widget.questions.length - 1) {
            _currentPage++;
            widget.pageController.animateToPage(_currentPage,
                duration: Duration(milliseconds: 300), curve: Curves.easeInSine);
          } else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizResults(state: widget.state, questions: widget.questions)));
            _currentPage = 0;
            // print('_currentPage => ${_currentPage} in else');
          }
        });
        // isRoundFinish = false;
        // print('isRoundFinish $isRoundFinish');
      }
    });

    _splashController.addListener(() {
      if (_splashController.status == AnimationStatus.completed) {
        _splashController.reset();
        if(_currentPage < 22 - 1){ // widget.questions.length - 1
          _currentPage++;
          widget.pageController.animateToPage(_currentPage,
              duration: Duration(milliseconds: 300), curve: Curves.easeInSine);
        }else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizResults(state: widget.state, questions: widget.questions)));
          _currentPage = 0;
          print('_currentPage => ${_currentPage} in else');
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _splashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _splashController.forward();
    return PageView.builder(
        controller: widget.pageController,
        physics: NeverScrollableScrollPhysics(),
        // itemCount: widget.questions.length,
        onPageChanged: (value) {
          //When page change, start the controller
          if(value > 1 && value % 2 != 0 ){
            _animationController.forward();
          }
          else{
            _splashController.forward();
          }
        },
        itemBuilder: (BuildContext context, int index) {
          print('index => ${index} // ${_currentPage} in build method');
          // print('${_currentPage} in build method'); // on으로 특정 값을 받으면 이를 이용하여 정답을 보여주자
          if(index == 0) return QuizSplashView(title: '준비');
          else if(index == 1) return QuizSplashView(title: '시작');
          else if(index > 1 && index % 2 == 0) return QuizSplashView(title: '${index - 1} 라운드');
          else {
            final idx = (index - 2) / 2;
            final question = widget.questions[idx.round()];
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
                            'Q ${index - 1} / ${widget.questions.length}',
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  HtmlCharacterEntities.decode(
                                      question.question),
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
                          child: AnimatedBuilder(
                              animation: _animationController,
                              builder: (BuildContext context, Widget? child) {
                                return QuizCompletionTimer(
                                    progress: _animationController.value);
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
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
                          isSelected: e == widget.state.selectedAnswer,
                          isCorrect: e == question.correctAnswer,
                          isDisplayingAnswer: widget.state.answered,
                          onTap: () => ref
                              .read(quizControllerProvider.notifier)
                              .submitAnswer(question, e)))
                      .toList(),
                ),
              ],
            );
          }
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

class QuizCompletionTimer extends ConsumerWidget {
  final double progress;

  const QuizCompletionTimer({Key? key, required this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomPaint(
      painter: timerBorderPaint(
          progress: progress,
          taskCompletedColor: progress < 0.5 ? Colors.yellow : Colors.red,
          taskNotCompletedColor: Colors.black),
      child: Center(
        child: Text('${10 - (progress * 10).floor()}',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20.0)),
      ),
    );
  }
}

class timerBorderPaint extends CustomPainter {
  // timerBorderPaint(
  //     this.progress, this.taskNotCompletedColor, this.taskCompletedColor);
  timerBorderPaint(
      {required this.progress,
        required this.taskNotCompletedColor,
        required this.taskCompletedColor}); // required for named parameter

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
  bool shouldRepaint(covariant timerBorderPaint oldDelegate) =>
      oldDelegate.progress != progress;
}