import 'package:bom_front/provider/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/room.dart';
import 'components/bom_menu.dart';
import 'components/bottom_navigation.dart';
import 'components/plan/appbar.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {

  @override
  Widget build(BuildContext context) {
    final rooms = ref.watch(roomListProvider);
    print(rooms);
    print(ref.read(roomListProvider.notifier).searchTheRoom());
    return Scaffold(
        appBar: BomAppBar(screenName: 'game',),
        drawer: BomMenu(),
        body: Column(
          children: [
            Container(
                child:rooms.when(
                    data: (data) {
                      return gridBody(data, context);
                    },
                    error: (e, st) => Container(),
                    loading: () => Container()
              )
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBarWidget(),
        );
  }
}

Widget gridBody(List<Room> display_list, BuildContext context) {
  return display_list.length == 0
      ? Center(
      child: Text(
        "결과가 없습니다.",
      ))
      : Expanded(
    // 없었을 때, verticalviewport error 해결
    child: GridView(
      padding: EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      children: display_list
          .map(
            (bomRoom) => GestureDetector(
          onTap: () {
            print('clicked');
            // _showDialog(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) =>
            //           CharacterDetails(character: bomCharacter)),
            // );
          },
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.4,
            ),
            margin: EdgeInsets.only(top: 10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(width: 4, color: Colors.orange),
              ),
              // color: Colors.white,
              elevation: 10,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(
                    //         Radius.circular(30.0))),
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    child: Image.network(
                      'https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/quiz.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0))),
                      child: Text('${bomRoom.roomName}',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
          .toList(),
    ),
  );
}