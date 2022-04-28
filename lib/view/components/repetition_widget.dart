import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/todo_provider.dart';

class BomRepetition extends ConsumerStatefulWidget {
  @override
  _BomRepetitionState createState() => _BomRepetitionState();
}

class _BomRepetitionState extends ConsumerState<BomRepetition> {
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [true, false, false, false];
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
                      margin: EdgeInsets.only(right: 3.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffdddddd), width: 2.3),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
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
                      margin: EdgeInsets.only(right: 3.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.3),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
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
                      margin: EdgeInsets.only(right: 3.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffdddddd), width: 2.3),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
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
                      margin: EdgeInsets.only(right: 3.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.3),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
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
                      margin: EdgeInsets.only(right: 3.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffdddddd), width: 2.3),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
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
                      margin: EdgeInsets.only(right: 3.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.3),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      child: Text(
                        '매주',
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
              !isSelected[3]
                  ? Container(
                      margin: EdgeInsets.only(right: 3.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffdddddd), width: 2.3),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 22.0,
                        color: Colors.black,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(right: 3.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.3),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 22.0,
                        color: Colors.black,
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
