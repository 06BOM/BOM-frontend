import 'package:bom_front/provider/statistic_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class monthAvgData extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<int> monthTimes = ref.watch(userMonthTimeProvider);
    AsyncValue<int> monthStars = ref.watch(userMonthStarProvider);
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
                    const Text(
                      "평균 공부 시간",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    monthTimes.when(
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
                    const Text(
                      "별 획득 개수",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    monthStars.when(
                        data: ((data) => Text(data.toString(),
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
