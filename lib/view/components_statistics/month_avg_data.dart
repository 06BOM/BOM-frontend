import 'package:bom_front/provider/statistic_provider.dart';
import 'package:bom_front/view/components_statistics/toggle_button_plan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/statistic_model.dart';

class monthAvgData extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<int> month_times = ref.watch(userMonthTimeProvider);
    AsyncValue<int> month_stars = ref.watch(userMonthStarProvider);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "평균 공부 시간",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    month_times.when(
                        data: ((data) => data ~/ 60 > 59
                            ? Column(
                                children: [
                                  Text('${((data ~/ 60) ~/ 60).toString()}시간',
                                      style: const TextStyle(
                                        fontSize: 25,
                                      )),
                                  Text('${((data ~/ 60) % 60).toString()}분',
                                      style: const TextStyle(
                                        fontSize: 25,
                                      ))
                                ],
                              )
                            : Text('${(data ~/ 60).toString()}분',
                                style: const TextStyle(
                                  fontSize: 25,
                                ))),
                        error: (err, stack) => Text('Error: $err'),
                        loading: () => Container()),
                  ]),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "별 획득 개수",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    month_stars.when(
                        data: ((data) => Text("${data.toString()}",
                            style: const TextStyle(
                              fontSize: 25,
                            ))),
                        error: (err, stack) => Text("Error: $err"),
                        loading: () => Container()),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
