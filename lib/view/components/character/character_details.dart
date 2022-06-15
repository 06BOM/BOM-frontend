import 'package:bom_front/model/character.dart';
import 'package:bom_front/provider/character_provider.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

import '../../../provider/user_privider.dart';
import '../../collection_view.dart';

class CharacterDetails extends ConsumerStatefulWidget {
  final Character character;

  const CharacterDetails({
    Key? key, required this.character
  }) : super(key: key);

  @override
  ConsumerState createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends ConsumerState<CharacterDetails> {

  var userInfo;

  @override
  void didChangeDependencies(){
    userInfo = ref.watch(userProvider.notifier).state;
  }

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;

    const ticks = [1, 3, 5, 7, 11];
    var features = ["두뇌", "체력", "기술", "스피드", "파워"];
    var data = [
      [
        widget.character.brain!,
        widget.character.strength!,
        widget.character.teq!,
        widget.character.speed!,
        widget.character.power!
      ],
    ];

    print('...토끼맨~');

    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 바로 적용이 안되는 경우가 있어서 위치 변경
            // ref.refresh(userProvider.notifier).getUser();
            ref.refresh(userProvider.notifier).getUser();
            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            //     builder: (BuildContext context) =>
            //         CollectionScreen()), (route) => false);
            ref.refresh(characterListProvider.notifier).getAllCharacter();
            final theCharacters = ref.watch(characterListProvider);
            Navigator.popUntil(context, (route) => route.isFirst);
            // Navigator.pop(context, theCharacters);
            // Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: SafeArea(
          child: Container(
            width: widthSize,
            height: heightSize,
            padding: EdgeInsets.only(left: 20.0, bottom: 20.0, right: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${widget.character.characterName}',
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
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                                Text('${widget.character.weight}.0kg'),
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
                                                Text(
                                                    '${(widget.character.height! * 0.1).toStringAsFixed(1)}m'),
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
                                                Text('${widget.character.mbti}'),
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
                                  Text('${widget.character.introduction}'),
                                  Container(
                                    width: 200.0,
                                    height: 200.0,
                                    margin: EdgeInsets.only(top: 80.0),
                                    child: RadarChart.light(
                                      data: data,
                                      features: features,
                                      ticks: ticks,
                                      // reverseAxis: true,
                                      useSides: true,
                                    ),
                                  ),
                                  userInfo.characterId == widget.character.characterId
                                      ? ElevatedButton(
                                          onPressed: null,
                                          child: Text('장착 중'),
                                        )
                                      : ElevatedButton(
                                          onPressed: () {
                                            ref.read(userProvider.notifier).editCharacter(userInfo.userId, widget.character.characterId ?? userInfo.characterId).then((value) =>
                                            {if (value) {
                                                setState(() {
                                              // userInfo = ref.watch(userProvider.notifier).state; // 딜레이 때문인지 못 불러오네...
                                              userInfo.characterId = widget.character.characterId; // 일단 이렇게 대처
                                            }),
                                                print(userInfo.characterId),
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              backgroundColor: Colors.teal[400],
                                              duration: Duration(milliseconds: 2000),
                                              behavior: SnackBarBehavior.floating,
                                              content: value ? Text('장착되었습니다') : Text('장착되지 않았습니다.'),
                                            )),
                                            }});
                                          },
                                          child: Text('장착'),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.orange,
                                              textStyle: const TextStyle(
                                                  color: Colors.grey)),
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
                            Image(
                              image: NetworkImage('${widget.character.imageUrl}'),
                              width: 200,
                              height: 200,
                              fit: BoxFit.fitHeight,
                              key: ValueKey('${widget.character.imageUrl}'),
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
