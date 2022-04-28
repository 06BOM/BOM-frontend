import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../provider/todo_provider.dart';
import 'add_view.dart';
import 'components/plan_appbar.dart';
import 'components/bottom_navigation.dart';
import 'components/calendar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'components/plan_item_widget.dart';

class HomeDetailScreen extends ConsumerStatefulWidget {
  const HomeDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeDetailScreen> createState() => _HomeDetailScreenState();
}

class _HomeDetailScreenState extends ConsumerState<HomeDetailScreen> {
  int index = 2;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(filteredTodos);
    AsyncValue<int> userStar = ref.watch(dailyUserStars);
    AsyncValue<int> dailyTimes = ref.watch(loadDailyTotalTimes);
    print('Home detail rebuilding...');
    return Scaffold(
        appBar: const BomAppBar(),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: SlidableAutoCloseBehavior(
                  child: ListView(
                    children: [
                      BomCalendar(pageCalendarFormat: CalendarFormat.week),
                      const SizedBox(height: 15.0),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120.0,
                        color: const Color(0xffA876DE),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                DateFormat('yyy.MM.dd EEE', 'ko_KR')
                                    .format(DateTime.now())
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20.0)),
                            const Text("00:00:00",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 60.0)),
                          ],
                        ),
                      ),
                      Container(
                        color: const Color(0xffefefef),
                        child: Column(
                          children: [
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                //모서리를 둥글게 하기 위해 사용
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              elevation: 1.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          60.0,
                                      padding:
                                          const EdgeInsets.only(left: 18.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('과목/목표',
                                              style: TextStyle(
                                                color: Color(0xff838383),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,
                                              )),
                                          Text('공부시간',
                                              style: TextStyle(
                                                color: Color(0xff838383),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,
                                              ))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    for (var i = 0; i < todos.length; i++) ...[
                                      if (i > 0) const SizedBox(height: 5),
                                      ProviderScope(
                                        overrides: [
                                          currentTodo
                                              .overrideWithValue(todos[i]),
                                        ],
                                        child: const PlanItem(type: false),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              // 통계 위치
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                //모서리를 둥글게 하기 위해 사용
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              elevation: 1.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25.0),
                                child: Column(
                                  children: [
                                    Container(
                                      // width: MediaQuery.of(context).size.width -
                                      //     60.0,
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          bottom: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('통계',
                                              style: TextStyle(
                                                color: Color(0xff838383),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,
                                              )),
                                          Text('2022년 4월 25일',
                                              style: TextStyle(
                                                color: Color(0xff838383),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.amberAccent,
                                            size: 40.0),
                                        userStar.when(
                                            data: ((data) => Text(
                                                '${data.toString()}개 획득',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0))),
                                            error: (err, stack) =>
                                                Text('Error: $err'),
                                            loading: () => Container()),
                                      ],
                                    ),
                                    SizedBox(height: 30.0),
                                    dailyTimes.when(
                                        data: ((data) => data ~/ 60 > 59
                                            ? Column(
                                                children: [
                                                  Text(
                                                      '${((data ~/ 60) ~/ 60).toString()}시간',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      '${((data ~/ 60) % 60).toString()}분',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
                                              )
                                            : Text(
                                                '${(data ~/ 60).toString()}분',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        error: (err, stack) =>
                                            Text('Error: $err'),
                                        loading: () => Container()),
                                    const SizedBox(height: 20.0),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: const Icon(Icons.expand_more),
                backgroundColor: const Color(0xffffffff),
                foregroundColor: Colors.grey,
                elevation: 0.0,
                mini: true,
                hoverColor: Colors.white,
                hoverElevation: 0.0,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 105.0),
              SpeedDial(
                backgroundColor: const Color(0xffA876DE),
                // add 0xff to front
                icon: Icons.add,
                activeIcon: Icons.close,
                spacing: 3,
                openCloseDial: isDialOpen,
                buttonSize: const Size(56.0, 56.0),
                childrenButtonSize: const Size(56.0, 56.0),
                visible: true,
                direction: SpeedDialDirection.up,
                renderOverlay: true,
                onOpen: () => debugPrint('OPENING DIAL'),
                onClose: () => debugPrint('DIAL CLOSED'),
                elevation: 8.0,
                isOpenOnStart: false,
                animationSpeed: 150,
                overlayColor: Colors.black,
                overlayOpacity: 0.5,
                childMargin: const EdgeInsets.symmetric(horizontal: 8.0),
                children: [
                  SpeedDialChild(
                    child: const Icon(
                      Icons.post_add,
                    ),
                    backgroundColor: Colors.white,
                    label: '추가',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AddPlan(type: false)));
                    },
                    onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
                  ),
                  SpeedDialChild(
                    child: const Icon(
                      Icons.delete_outline,
                    ),
                    backgroundColor: Colors.white,
                    label: '삭제',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text(("Third Child Pressed")))),
                    onLongPress: () => debugPrint('THIRD CHILD LONG PRESS'),
                  ),
                  SpeedDialChild(
                      child: const Icon(
                        Icons.edit_note,
                      ),
                      backgroundColor: Colors.white,
                      // foregroundColor: Colors.white,
                      label: '수정',
                      visible: true,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddPlan(
                                      type: true,
                                    ))); // 일단, 특정 플랜을 선택할 수 있게 하고 뒤에 그 플랜의 제목을 주어야한다.
                        // 플랜을 눌렀을 때, 임시 수정할 수 있도록 하였다.
                      }),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBarWidget(index: index));
  }
}
