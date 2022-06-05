import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class QuizSplashView extends StatelessWidget {
  final title;
  const QuizSplashView({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 150.0,
          color: bgColor,
          margin: const EdgeInsets.only(
            top: 80.0,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = Colors.grey[300]!,
                        shadows: [
                          Shadow(
                            blurRadius: 25.0,
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                        letterSpacing: 4.0),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                        color: Colors.yellow,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(5.0, 5.0),
                          ),
                        ],
                        letterSpacing: 4.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
