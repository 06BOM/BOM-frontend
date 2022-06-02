import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:table_calendar/table_calendar.dart';
import '../provider/todo_provider.dart';
import '../utils.dart';
import 'add_view.dart';
import 'components/bom_menu.dart';
import 'components/plan/appbar.dart';
import 'components/bottom_navigation.dart';
import 'components/plan/calendar.dart';
import 'components/plan/plan_item_widget.dart';
import 'components_statistics/daily_statistic.dart';
import 'components_statistics/month_avg_data.dart';
import 'components_statistics/statistic_chart_view.dart';
import 'components_statistics/toggle_button_plan.dart';
import 'components_statistics/weekly_avg_data.dart';

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
    final userSelectedDay = ref.watch(selectedDate);
    final filter = ref.watch(segmentType);
    final todos = ref.watch(filteredTodos);
    AsyncValue<int> userStar = ref.watch(dailyUserStars);
    AsyncValue<int> dailyTimes = ref.watch(loadDailyTotalTimes);
    print('Home detail rebuilding...');

    for (var element in todos) {
      print(element.time!);
    }

    return Scaffold(
        appBar: const BomAppBar(),
        drawer: const BomMenu(),
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
                            Text(changeDateFormat(userSelectedDay),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20.0)),
                            Text(
                                secToMin(todos.fold(
                                    0,
                                    (previous, current) =>
                                        previous +
                                        current.time!)), // 1800 = 30min
                                style: const TextStyle(
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
                                      // width: MediaQuery.of(context).size.w idth -
                                      //     60.0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
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
                                    if (todos.isEmpty)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text('작성한 플랜이 없습니다.',
                                              style: TextStyle(
                                                color: Color(0xff838383),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15.0,
                                              )),
                                        ],
                                      )
                                    else
                                      for (var i = 0;
                                          i < todos.length;
                                          i++) ...[
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
                                        children: [
                                          const Text('통계',
                                              style: TextStyle(
                                                color: Color(0xff838383),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,
                                              )),
                                          Text(
                                              getTodayKoreanFormat(userSelectedDay),
                                              style: const TextStyle(
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
                                        const Icon(Icons.star,
                                            color: Colors.amberAccent,
                                            size: 40.0),
                                        userStar.when(
                                            data: ((data) => Text(
                                                '${data.toString()}개 획득',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0))),
                                            // error: (err, stack) =>
                                            //     Text('Error: $err'), // throw한 error를 알려주기 때문에 유저경험을 위해 0개로 default
                                            error: (err, stack) => const Text('0개 획득',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        18.0)), // 우는 캐릭터로 대체하기
                                            loading: () => Container()),
                                      ],
                                    ),
                                    const SizedBox(height: 20.0),
                                    DailyChart(),
                                    const SizedBox(height: 40.0),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 2.0,
                                    ),
                                    togglebuttonState(),
                                    filter == SegmentType.week
                                        ? dailyAvgData()
                                        : monthAvgData(),
                                    filter == SegmentType.week
                                        ? const BarChartWeek()
                                        : const BarChartWeek(),
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
                  ref.read(selectedDate.notifier).state =
                      DateTime.now().add(const Duration(hours: 9));
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 105.0),
              if (userSelectedDay.compareTo(
                          DateTime.now().add(const Duration(hours: 9))) <
                      0 &&
                  !isToday(userSelectedDay))
                const FloatingActionButton(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.grey,
                  onPressed: null,
                )
              else
                FloatingActionButton(
                  heroTag: 'add',
                  child: const Icon(Icons.add),
                  backgroundColor: const Color(0xffA876DE),
                  onPressed: () {
                    ref.read(categoryIdToCreate.notifier).state = 1;
                    ref.read(repetitionTypeToCreate.notifier).state = 0;
                    ref.read(limitedDate.notifier).state = '';
                    ref.read(selectedWeek.notifier).state = [
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0
                    ];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPlan(
                                type: false,
                                dayToCreatePlan: userSelectedDay)));
                  },
                )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: const BottomNavigationBarWidget());
  }
}
