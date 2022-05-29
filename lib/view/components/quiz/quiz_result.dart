import 'package:bom_front/main.dart';
import 'package:bom_front/provider/quiz/quiz_provider.dart';
import 'package:bom_front/repository/quiz/quiz_repository.dart';
import 'package:bom_front/view/main_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/question.dart';
import '../../../provider/quiz/quiz_state.dart';
import '../../../provider/room_data_provider.dart';
import '../../../utils/colors.dart';
import '../../wating_screen.dart';
import 'custom_button.dart';

class QuizResults extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersScoreInfo = ref.watch(scoreProvider.notifier).state;
    usersScoreInfo.sort((a, b) => a[1].compareTo(b[1]) * -1);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color(0xffCEAAF4),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: <Widget>[
                Text(
                  '최종결과',
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 4
                        ..color = Color(0xff98A1BD),
                      shadows: [
                        Shadow(
                          blurRadius: 6.0,
                          color: Colors.grey,
                          offset: Offset(4.0, 4.0),
                        ),
                      ]
                  ),
                ),
                Text(
                  '최종결과',
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFBE300),
                      shadows: [
                        Shadow(
                          blurRadius: 6.0,
                          color: Colors.grey,
                          offset: Offset(4.0, 4.0),
                        ),
                      ]
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.0),
            for (var i = 0; i < usersScoreInfo.length; i++)
              Card(
                color: Color(0xffD5DCEC),
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 80.0,
                    height: 60.0,
                    child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Text(
                      '${usersScoreInfo[i][0]}',
                      style: const TextStyle(
                        color: Color(0xff6275B8),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true, // 텍스트가 영역을 넘어갈 경우 줄바꿈 여부
                      textAlign: TextAlign.center, // 정렬
                    ),
                    Text(
                      '${usersScoreInfo[i][1]}',
                      style: const TextStyle(
                        color: bgColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true, // 텍스트가 영역을 넘어갈 경우 줄바꿈 여부
                      textAlign: TextAlign.center, // 정렬
                    ),
                ],
              ),
                  )),
            SizedBox(height: 8.0),
            TextButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WaitingLobby()));
            }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('대기방으로 돌아가기', style: TextStyle(color: bgColor, fontWeight: FontWeight.w600),),
                SizedBox(width: 5.0),
                Icon(Icons.navigate_next),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
