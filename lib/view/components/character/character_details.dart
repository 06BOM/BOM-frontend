import 'package:bom_front/model/character.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CharacterDetails extends StatelessWidget {
  final Character character;

  const CharacterDetails({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;

    const ticks = [1, 3, 5, 7, 11];
    var features = ["두뇌", "체력", "기술", "스피드", "파워"];
    var data = [
      [10, 2, 7, 1, 5],
    ];

    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: SafeArea(
          child: Container(
            width: widthSize,
            height: heightSize,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent)),
            padding: EdgeInsets.only(left: 20.0, bottom: 20.0, right: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('토끼맨',
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ],
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 160,
                        width: widthSize * 0.9,
                        height: heightSize * 0.9,
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.scale),
                                                SizedBox(width: 3.0),
                                                Text('10.0kg'),
                                              ],
                                            ),
                                            Text('몸무게',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey[400]))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Transform.rotate(
                                                    angle: 90 * math.pi / 180,
                                                    child:
                                                        Icon(Icons.straighten)),
                                                SizedBox(width: 3.0),
                                                Text('0.4m'),
                                              ],
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 7.0),
                                              child: Text('키',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.grey[400])),
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text('ENTP'),
                                              ],
                                            ),
                                            Text('MBTI',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey[400]))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Text('당근족의 비선실세,\n 세계 5대 당근을 지키기 위해 밤샘근무 중~'),
                                  Container(
                                    width: 200.0,
                                    height: 200.0,
                                    child: RadarChart.light(
                                      data: data,
                                      features: features,
                                      ticks: ticks,
                                      // reverseAxis: true,
                                        useSides: true,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              '${character.imageUrl}',
                              width: 200,
                              height: 200,
                              fit: BoxFit.fitHeight,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
