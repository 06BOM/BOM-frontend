import 'package:bom_front/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/todo_provider.dart';

class BomRepetition extends ConsumerStatefulWidget {
  final Todo? data;
  const BomRepetition({this.data});

  @override
  _BomRepetitionState createState() => _BomRepetitionState();
}

class _BomRepetitionState extends ConsumerState<BomRepetition> {
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [false, false, false];
    isSelected[widget.data?.repetitionType ?? 0] = true; // repetitionType이 3넘어갈 경우 에러 (오류 처리해주자)
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ToggleButtons(
            borderColor: Colors.transparent,
            fillColor: Colors.transparent,
            borderWidth: null,
            selectedBorderColor: Colors.transparent,
            selectedColor: Colors.transparent,
            splashColor: Colors.transparent,
            children: <Widget>[
              !isSelected[0]
                  ? Container(
                      margin: const EdgeInsets.only(right: 3.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffdddddd), width: 1.8),
                        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                      ),
                      child: Text(
                        '안함',
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(right: 3.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.8),
                        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                      ),
                      child: Text(
                        '안함',
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
              !isSelected[1]
                  ? Container(
                      margin: const EdgeInsets.only(right: 3.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffdddddd), width: 1.8),
                        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                      ),
                      child: Text(
                        '매일',
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(right: 3.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.8),
                        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                      ),
                      child: Text(
                        '매일',
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
              !isSelected[2]
                  ? Container(
                      margin: const EdgeInsets.only(right: 3.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffdddddd), width: 1.8),
                        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                      ),
                      child: Text(
                        '매주',
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(right: 3.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.8),
                        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                      ),
                      child: Text(
                        '매주',
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
            onPressed: (int index) {
              ref.read(repetitionTypeToCreate.notifier).state = index;
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  isSelected[i] = i == index;
                }
              }
              );
            },
            isSelected: isSelected,
          ),
        ),
      ],
    );
  }
}
