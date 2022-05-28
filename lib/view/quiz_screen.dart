
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../network/socket_method.dart';
import 'dart:math' as math;
import '../provider/room_data_provider.dart';
import 'components/quiz/quiz_question.dart';

class QuizScreen extends ConsumerStatefulWidget {
  static String routeName = '/quiz-room';

  const QuizScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {

  final SocketMethods _socketMethods = SocketMethods();

@override
  void didChangeDependencies() {
    _socketMethods.exitRoomAnswerListener(context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    // final quizQuestions = ref.watch(quizQuestionProvider); // useProvider();
    final pageController = PageController(initialPage: 0);

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/background.png'), // 배경 이미지
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: GestureDetector(
              child: Transform(
                  transform: Matrix4.rotationY(math.pi),
                  alignment: Alignment.center,
                  child: Icon(Icons.logout, color: Colors.white)),
              onTap: () {
                _socketMethods.handleRoomExit(context, ref);
                // Navigator.pop(context);
              },
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: Icon(Icons.settings, color: Colors.white),
              ),
            ],
          ),
          body: _buildBody(context, pageController)
          // body: quizQuestions.when(
          //   data: (questions) => _buildBody(context, pageController, questions),
          //   error: (error, _) => QuizError(
          //     message: error is Failure ? error.message : 'Something went wrong!',
          //   ),
          //   loading: () => const Center(child: CircularProgressIndicator()),
          // ),
          // bottomSheet: quizQuestions.maybeWhen(
          //   data: (questions) {
          //     final quizState = ref.watch(quizControllerProvider);
          //     if (!quizState.answered) return const SizedBox.shrink();
          //     return CustomButton(
          //       title: pageController.page!.toInt() + 1 < questions.length
          //           ? 'Next Question'
          //           : 'See Results',
          //       onTap: () {
          //         ref
          //             .read(quizControllerProvider.notifier)
          //             .nextQuestion(questions, pageController.page!.toInt());
          //         if (pageController.page!.toInt() + 1 < questions.length) { // 넘기감: page가 퀴즈 개수 보다 작을 경우
          //           pageController.nextPage(
          //             duration: const Duration(milliseconds: 250),
          //             curve: Curves.easeInOut,
          //           );
          //         }
          //       },
          //     );
          //   },
          //   orElse: () => const SizedBox.shrink(),
          // ),
          ),
    );
  }

  Widget _buildBody(BuildContext context, PageController pageController) {
    return Consumer(builder: (context, ref, child) {
      // final quizState = ref.watch(quizControllerProvider);
      final roomName = ref.watch(roomDataProvider)[0];
      return QuizQuestions(
        pageController: pageController,
        roomName: roomName,
      )
          // quizState.status == QuizStatus.complete
          //   ? QuizResults(state: quizState, questions: questions)
          //   : QuizQuestions(
          // pageController: pageController,
          // state: quizState,
          // questions: questions,
          // roomName: roomName,)
          ;
    });
  }
}
