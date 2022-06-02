import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BomColor extends ConsumerStatefulWidget {
  const BomColor({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BomColorState();
}

class _BomColorState extends ConsumerState<BomColor> {
  late List<bool> isSelected;
  Color color = const Color(0xffA876DE);

  @override
  void initState() {
    isSelected = [true, false, false, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 50.0,
        width: 200, // Expanded로 잘 안된다.
          child: ListView(scrollDirection: Axis.horizontal, children: [
            ToggleButtons(
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
                        child: const Icon(
                          Icons.circle,
                          color: Color(0xffA876DE),
                          size: 38.0,
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(right: 3.0),
                        child: const Icon(
                          Icons.check_circle,
                          color: Color(0xffA876DE),
                          size: 38.0,
                        ),
                      ),
                !isSelected[1]
                    ? Container(
                        margin: const EdgeInsets.only(right: 3.0),
                        child: const Icon(
                          Icons.circle,
                          color: Color(0xffff6666),
                          size: 38.0,
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(right: 3.0),
                        child: const Icon(
                          Icons.check_circle,
                          color: Color(0xffff6666),
                          size: 38.0,
                        ),
                      ),
                !isSelected[2]
                    ? Container(
                        margin: const EdgeInsets.only(right: 3.0),
                        child: const Icon(
                          Icons.circle,
                          color: Color(0xff6699ff),
                          size: 38.0,
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(right: 3.0),
                        child: const Icon(
                          Icons.check_circle,
                          color: Color(0xff6699ff),
                          size: 38.0,
                        ),
                      ),
                !isSelected[3]
                    ? Container(
                        margin: const EdgeInsets.only(right: 3.0),
                        child: const Icon(
                          Icons.circle,
                          color: Color(0xffBDECB6),
                          size: 38.0,
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(right: 3.0),
                        child: const Icon(
                          Icons.check_circle,
                          color: Color(0xffBDECB6),
                          size: 38.0,
                        ),
                      ),
                // if(isSelected.length > 4){ // provider로 생성해야할 듯
                //
                // }
              ],
              onPressed: (int index) {
                // ref.read(repetitionTypeToCreate.notifier).state = index;
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] = i == index;
                  }
                });
              },
              isSelected: isSelected,
            ),
          ]),
        ),
        ElevatedButton(
          onPressed: () {
            pickColor(context);
          },
          child: const Icon(Icons.add, color: Colors.white, size: 22),
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(20, 20),
              shape: const CircleBorder(),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: Colors.grey),
        )
      ],
    );
  }

  void pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (Context) => AlertDialog(
          alignment: Alignment.center,
          title: const Text('원하는 색상을 선택해주세요'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildColorPickerBlockVer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text(
                      '선택',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffA876DE),
                    ),
                    onPressed: () {
                      isSelected.add(false); // provider refresh해주기
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(), style: TextButton.styleFrom(
                    primary: const Color(0xffA876DE),
                  ),
                      child: const Text('취소', style: TextStyle(fontSize: 20)))
                ],
              ),
            ],
          )));

  Widget buildColorPicker() => ColorPicker(
      pickerColor: color,
      enableAlpha: false,
      labelTypes: const [],
      onColorChanged: (color) => setState(() => this.color = color));

  Widget buildColorPickerBlockVer() => BlockPicker(
      pickerColor: color,
      availableColors: const [
        Colors.teal,
        Colors.deepOrange,
        Colors.cyanAccent,
        Colors.pinkAccent,
        Colors.pink,
        Colors.purple,
        Colors.deepPurple,
        Colors.indigo,
        Colors.lightBlue,
        Colors.cyan,
        Colors.teal,
        Colors.lightGreen,
        Colors.lime,
        Colors.yellow,
        Colors.amber,
        Colors.orange,
        Colors.brown,
        Colors.grey,
        Colors.blueGrey,
        Colors.black,
      ],
      onColorChanged: (color) => setState(() => this.color = color)); // hexa값을 category에 넣기
}
