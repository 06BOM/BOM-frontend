import 'package:equatable/equatable.dart';
import '../../model/question.dart';

/*
The user has not chosen an answer (initial)
The user has selected a correct answer (correct)
The user has selected an incorrect answer (incorrect)
And the user has completed the provider.quiz (complete)
 */

enum QuizStatus { initial, correct, incorrect, complete }

class QuizState extends Equatable {
  final String selectedAnswer;
  final List<Question> correct;
  final List<Question> incorrect;
  final QuizStatus status;

  bool get answered =>
      status == QuizStatus.incorrect || status == QuizStatus.correct;

  const QuizState({
    required this.selectedAnswer,
    required this.correct,
    required this.incorrect,
    required this.status,
  });

  factory QuizState.initial() { // 처음부터 시작
    return QuizState( // if const가 앞에 온다면, Error: Unsupported operation: Cannot add to an unmodifiable list
      selectedAnswer: '',
      correct: [],
      incorrect: [],
      status: QuizStatus.initial,
    );
  }

  @override
  List<Object?> get props => [
    selectedAnswer,
    correct,
    incorrect,
    status,
  ];

  QuizState copyWith({
    String? selectedAnswer,
    List<Question>? correct,
    List<Question>? incorrect,
    QuizStatus? status,
  }) {
    return QuizState(
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      correct: correct ?? this.correct,
      incorrect: incorrect ?? this.incorrect,
      status: status ?? this.status,
    );
  }
}