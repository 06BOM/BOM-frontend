import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../enum/difficulty.dart';
import '../model/failure.dart';
import '../model/question.dart';
import '../provider/quiz/quiz_provider.dart';
import '../provider/quiz/quiz_state.dart';
import '../repository/quiz/quiz_repository.dart';
import 'components/quiz/custom_button.dart';
import 'components/quiz/quiz_error.dart';
import 'components/quiz/quiz_question.dart';
import 'components/quiz/quiz_result.dart';

final quizQuestionProvider = FutureProvider.autoDispose<List<Question>>(
        (ref) => ref.watch(quizRepositoryProvider).getQuestions(
      // refresh를 위한 watch
        numQuestions: 5,
        categoryId: Random().nextInt(24) + 9, // 9 ~ 32
        difficulty: Difficulty.any));

class QuizScreen extends HookConsumerWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizQuestions = ref.watch(quizQuestionProvider); // useProvider();
    final pageController = usePageController();
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/background.png'), // 배경 이미지
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // 필수
        body: quizQuestions.when(
          data: (questions) => _buildBody(context, pageController, questions),
          error: (error, _) => QuizError(
            message: error is Failure ? error.message : 'Something went wrong!',
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
        bottomSheet: quizQuestions.maybeWhen(
          data: (questions) {
            final quizState = ref.watch(quizControllerProvider);
            if (!quizState.answered) return const SizedBox.shrink();
            return CustomButton(
              title: pageController.page!.toInt() + 1 < questions.length
                  ? 'Next Question'
                  : 'See Results',
              onTap: () {
                ref
                    .read(quizControllerProvider.notifier)
                    .nextQuestion(questions, pageController.page!.toInt());
                if (pageController.page!.toInt() + 1 < questions.length) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.linear,
                  );
                }
              },
            );
          },
          orElse: () => const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, PageController pageController,
      List<Question> questions) {
    if (questions.isEmpty) return QuizError(message: 'No questions found.');
    return Consumer(builder: (context, ref, child) {
      final quizState = ref.watch(quizControllerProvider);
      return quizState.status == QuizStatus.complete
          ? QuizResults(state: quizState, questions: questions)
          : QuizQuestions(
        pageController: pageController,
        state: quizState,
        questions: questions,
      );
    });
  }
}