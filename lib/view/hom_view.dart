import 'package:bom_front/provider/user_privider.dart';
import 'package:bom_front/view/components/plan/appbar.dart';
import 'package:bom_front/view/components/plan/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../provider/character_provider.dart';
import '../provider/todo_provider.dart';
import 'components/bom_menu.dart';
import 'components/bottom_navigation.dart';
import 'components/plan/filter_button_widget.dart';
import 'components/plan/plan_item_widget.dart';
import 'home_detail_view.dart';

final userDeviceHeight = StateProvider<double>((ref) => 0.0);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = ref
        .watch(userDeviceHeight.notifier)
        .state =
        MediaQuery
            .of(context)
            .size
            .height *
            MediaQuery
                .of(context)
                .devicePixelRatio;
    // AsyncValue<List<Todo>> asyncTodos = ref.watch(planStateFuture); -> error 처리와 많은 양을 불러올 때 로딩필요시
    // final todos = ref.watch(todoListProvider);

    final todos = ref.watch(filteredTodos);
    final user = ref.watch(userProvider);
    // ref.watch(characterListProvider.notifier).state; // collection_view -> didChangeDependencies 내부에서 처음 불러오지 않기 때문에 여기서 먼저 호출 (검색표시 경우)
    // print('current todos length = ${todos.length}');
    // print('Home rebuilding...deviceHeight : ${deviceHeight}');
    // for (var i = 0; i < todos.length; i++) {
    //   print('Each plan\'s userId = ${todos[i].userId}');
    // }

    return Scaffold(
      appBar: const BomAppBar(),
      drawer: const BomMenu(),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: BomCalendar(pageCalendarFormat: CalendarFormat.month)),
            const SizedBox(height: 4), // to protect appBar block
            deviceHeight > 1500.0
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(children: const <Widget>[
                Expanded(
                    child: Divider(
                        height: 1.0,
                        thickness: 0.3,
                        color: Colors.grey)),
                Text("오늘의 목표",
                    style: TextStyle(
                        color: Colors
                            .grey)), // Text의 고정 높이 때문에 더이상 아래 Expanded가 안늘려짐
                Expanded(
                    child: Divider(
                        height: 1.0,
                        thickness: 0.3,
                        color: Colors.grey)),
              ]),
            )
                : Container(),
            Expanded(
              child: Container(
                color: const Color(0xffefefef),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    //모서리를 둥글게 하기 위해 사용
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 1.0,
                  child: Column(
                    children: [
                      const SizedBox(height: 14),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              const Expanded(flex: 2, child: FilterButtons()),
                              Expanded(
                                flex: 7,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, bottom: 16.0),
                                  child: todos.isNotEmpty
                                      ? ListView(
                                    // ListView.builder 또한 ok -> Listview: home에는 필요 detail에는 필요 x
                                    children: [
                                      for (var i = 0;
                                      i < todos.length;
                                      i++) ...[
                                        if (i > 0)
                                          const SizedBox(height: 5),
                                        ProviderScope(
                                          overrides: [
                                            currentTodo
                                                .overrideWithValue(
                                                todos[i]),
                                          ],
                                          child: const PlanItem(
                                              type: true),
                                        ),
                                      ],
                                    ],
                                  )
                                      : Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: const [
                                      Text('작성한 플랜이 없습니다.',
                                          style: TextStyle(
                                            color: Color(0xff838383),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.0,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(height: 19),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.expand_less),
        backgroundColor: const Color(0xffffffff),
        foregroundColor: Colors.grey,
        hoverColor: Colors.white,
        hoverElevation: 0.0,
        elevation: 0.0,
        mini: true,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeDetailScreen()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}