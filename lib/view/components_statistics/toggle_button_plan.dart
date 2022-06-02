import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


enum SegmentType { week, month }

final segmentType = StateProvider((ref) => SegmentType.week);

class togglebuttonState extends HookConsumerWidget {
  int? value;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: CustomSlidingSegmentedControl<SegmentType>(
          initialValue: SegmentType.week,
          isStretch: true,
          children: const {
            SegmentType.week: Text(
              '주',
              textAlign: TextAlign.center,
            ),
            SegmentType.month: Text(
              '월',
              textAlign: TextAlign.center,
            ),
          },
          innerPadding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(14),
          ),
          thumbDecoration: BoxDecoration(
            color: const Color(0xffA876DE),
            borderRadius: BorderRadius.circular(12),
          ),
          onValueChanged: (v) {
            if (v == SegmentType.week) {
              ref.read(segmentType.notifier).state = SegmentType.week;
            } else {
              ref.read(segmentType.notifier).state = SegmentType.month;
            }
          },
        ),
      ),
    );
  }
}
