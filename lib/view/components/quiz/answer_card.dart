import 'package:flutter/material.dart';
import 'package:html_character_entities/html_character_entities.dart';

import 'box_shadow.dart';
import 'correct_icon.dart';

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isDisplayingAnswer;
  final VoidCallback onTap;

  AnswerCard(
      {Key? key,
        required this.answer,
        required this.isCorrect,
        required this.isDisplayingAnswer,
        required this.isSelected,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(
    //     'ALL: 내가선택한 것 => $isSelected / 각 문제의 답(4개) => $answer / 대답했는가? => $isDisplayingAnswer');
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 20.0,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 20.0,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: boxShadow,
            border: Border.all(
              color: isDisplayingAnswer
                  ? (isCorrect // 뭐든 눌렀을 때,
                  ? Colors.green // 정답
                  : (isSelected // 내가 선택했을 때와 안했을 때
                  ? Colors.red
                  : Colors.white))
                  : Colors.white,
              width: 4.0,
            ),
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  HtmlCharacterEntities.decode(answer),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: isDisplayingAnswer && isCorrect
                        ? FontWeight.bold
                        : FontWeight.w400,
                  ),
                ),
              ),
              if (isDisplayingAnswer)
                isCorrect
                    ? const CircularIcon(icon: Icons.check, color: Colors.green)
                    : isSelected // 틀린 것 중 내가 선택한 것만 x 표시
                    ? const CircularIcon(
                  icon: Icons.close,
                  color: Colors.red,
                )
                    : const SizedBox.shrink()
            ],
          ),
        ));
  }
}