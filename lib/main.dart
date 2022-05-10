import 'package:bom_front/view/quiz_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Colors.transparent),
      ),
      home: Scaffold(
        body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             ElevatedButton(onPressed: (){
               Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) => const QuizScreen()));
             }, child: Text('시작하시겠습니까?'))
           ],
         ),
        )
      ),
    );
  }
}