import 'package:bom_front/model/user.dart';
import 'package:bom_front/provider/room_provider.dart';
import 'package:bom_front/view/components/quiz/create_room_sheet.dart';
import 'package:bom_front/view/components/quiz/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../model/room.dart';
import '../network/socket_method.dart';
import '../provider/user_privider.dart';
import '../utils/colors.dart';
import 'components/bom_menu.dart';
import 'components/bottom_navigation.dart';
import 'components/plan/appbar.dart';
import 'components/quiz/custom_textfield.dart';
import 'create_room_screen.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // _socketMethods.getJoinedUserName(context); // createRoomSuccessListener로 가야하나? 방정보를 얻기위해?
    _socketMethods.getJoinedUserName(context, ref);
    _socketMethods.joinRoomFailListener(context);
    // _socketMethods.updateRoomListener(context); // 사용할지 고려
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rooms = ref.watch(roomListProvider);
    // print(rooms);
    // print(ref.read(roomListProvider.notifier).searchTheRoom());
    return Scaffold(
      appBar: BomAppBar(
        screenName: 'game',
      ),
      drawer: BomMenu(),
      body: Column(
        children: [
          Container(
              child: rooms.when(
                  data: (data) {
                    return gridBody(data, context, _socketMethods);
                  },
                  error: (e, st) => Container(),
                  loading: () => Container()))
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: const Icon(Icons.refresh, color: Color(0xffA876DE)),
              backgroundColor: const Color(0xffffffff),
              foregroundColor: Colors.grey,
              elevation: 1.5,
              mini: true,
              hoverColor: Colors.white,
              hoverElevation: 0.0,
              onPressed: () {
                print('update!');
                ref.refresh(roomListProvider.notifier).getAllRooms();
              },
            ),
            const SizedBox(width: 105.0),
            FloatingActionButton(
              heroTag: 'add',
              child: const Icon(Icons.add),
              backgroundColor: const Color(0xffA876DE),
              onPressed: () {
                print('click');
                // Navigator.pushNamed(context, CreateRoomScreen.routeName);
                showModalBottomSheet(
                  isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      )
                    ),
                    context: context,
                    builder: (context) => CreateRoomSheet(),
                  // isDismissible: false,
                  // enableDrag: false,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}

Widget gridBody(List<Room> display_list, BuildContext context, SocketMethods _socketMethods) {
  return display_list.length == 0
      ? Expanded(
        child: Center(
            child: Text(
            "방이 존재하지 않습니다.",
          )),
      )
      : Expanded(
          // 없었을 때, verticalviewport error 해결
          child: GridView(
            padding: EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
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
                      _socketMethods.joinRoom(
                          'BOM', bomRoom.roomName!);
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.4,
                      ),
                      margin: EdgeInsets.only(top: 10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        elevation: 10,
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              child: Image.network(
                                'https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/quiz.jpg',
                                fit: BoxFit.fill,
                              ), // Text(key['title']),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3.0, horizontal: 8.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    // color: Color(0xffA876DE),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        // margin: EdgeInsets.only(left: 7.0),
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(13.0)),
                                        child: Text('${bomRoom.subject}',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red[600]))),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${bomRoom.roomName}',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black)),
                                        Text('10점 내기',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[600]))
                                      ],
                                    ),
                                    Text('${bomRoom.participantsNum} / 8',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black))
                                  ],
                                ),
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
