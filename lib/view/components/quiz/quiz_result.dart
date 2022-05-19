import 'package:bom_front/main.dart';
import 'package:bom_front/provider/quiz/quiz_provider.dart';
import 'package:bom_front/repository/quiz/quiz_repository.dart';
import 'package:bom_front/view/main_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/question.dart';
import '../../../provider/quiz/quiz_state.dart';
import 'custom_button.dart';

class QuizResults extends ConsumerWidget {
  final QuizState state;
  final List<Question> questions;

  QuizResults({
    Key? key,
    required this.state,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${state.correct.length} / ${questions.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 60.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'CORRECT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            CustomButton(
              title: 'New Quiz',
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainMenuScreen()));
                ref.refresh(
                    quizRepositoryProvider); // watch 상태에서 바뀐걸 인지하니까 다시 데이터를 불러옴
                ref.read(quizControllerProvider.notifier).reset();
              },
            ),
          ],
        ),
      ),
    );
  }
}