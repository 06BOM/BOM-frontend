// 반복되는 함수, 색, 전역변수를 포함한다
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

// void showGameDialog(BuildContext context, String text) {
//   showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(text),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 GameMethods().clearBoard(context);
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 'Play Again',
//               ),
//             ),
//           ],
//         );
//       });
// }