import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../repository/quiz/quiz_repository.dart';
import 'custom_button.dart';

class QuizError extends StatelessWidget {
  final String message;

  const QuizError({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(message,
                style: const TextStyle(color: Colors.white, fontSize: 20.0)),
            const SizedBox(height: 20.0),
            CustomButton(
              title: 'Retry',
              onTap: () => ref.refresh(quizRepositoryProvider),
            ),
          ]),
        );
      },
    );
  }
}