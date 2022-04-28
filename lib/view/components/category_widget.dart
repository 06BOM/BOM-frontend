import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/todo_provider.dart';

class BomCategory extends ConsumerStatefulWidget {
  @override
  _BomCategoryState createState() => _BomCategoryState();
}

class _BomCategoryState extends ConsumerState<BomCategory> {
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [true, false, false, false, false];
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      margin: EdgeInsets.only(right: 3.0),
                      decoration: BoxDecoration(
                        color: Color(0x12735BF2),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.trip_origin,
                            color: Colors.grey,
                            size: 12.0,
                          ),
                          SizedBox(width: 1.0),
                          Text(
                            '국어',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(right: 3.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0x26735BF2),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.lens,
                            color: Color(0xcc735BF2),
                            size: 12.0,
                          ),
                          SizedBox(width: 1.0),
                          Text(
                            '국어',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
              !isSelected[1]
                  ? Container(
                      margin: EdgeInsets.only(right: 3.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0x1200B383),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.trip_origin,
                            color: Colors.grey,
                            size: 12.0,
                          ),
                          SizedBox(width: 1.0),
                          Text(
                            '수학',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(right: 3.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0x2600B383),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.lens,
                            color: Color(0xcc00B383),
                            size: 12.0,
                          ),
                          SizedBox(width: 1.0),
                          Text(
                            '수학',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
              !isSelected[2]
                  ? Container(
                      margin: EdgeInsets.only(right: 3.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0x120095FF),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.trip_origin,
                            color: Colors.grey,
                            size: 12.0,
                          ),
                          SizedBox(width: 1.0),
                          Text(
                            '영어',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(right: 3.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0x260095FF),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.lens,
                            color: Color(0xcc0095FF),
                            size: 12.0,
                          ),
                          SizedBox(width: 1.0),
                          Text(
                            '영어',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
              !isSelected[3]
                  ? Container(
                      margin: EdgeInsets.only(right: 3.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0x12FFCE01),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.trip_origin,
                            color: Colors.grey,
                            size: 12.0,
                          ),
                          SizedBox(width: 1.0),
                          Text(
                            '사회',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(right: 3.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0x26FFCE01),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.lens,
                            color: Color(0xccFFCE01),
                            size: 12.0,
                          ),
                          SizedBox(width: 1.0),
                          Text(
                            '사회',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
              !isSelected[4]
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0x12EF5DA8),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.trip_origin,
                            color: Colors.grey,
                            size: 12.0,
                          ),
                          SizedBox(width: 1.0),
                          Text(
                            '과학',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Color(0x26EF5DA8),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.lens,
                            color: Color(0xccEF5DA8),
                            size: 12.0,
                          ),
                          SizedBox(width: 1.0),
                          Text(
                            '과학',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
            ],
            onPressed: (int index) {
              ref.read(categoryIdToCreate.notifier).state = index;
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  isSelected[i] = i == index;
                }
              });
            },
            isSelected: isSelected,
          ),
        ),
      ],
    );
  }
}
