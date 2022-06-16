import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../network/socket_method.dart';
import '../../../provider/user_privider.dart';
import '../../../utils/colors.dart';
import 'custom_button.dart';
import 'custom_textfield.dart';

class CreateRoomSheet extends ConsumerStatefulWidget {
  const CreateRoomSheet({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateRoomSheetState();
}

class _CreateRoomSheetState extends ConsumerState<CreateRoomSheet> {
  final TextEditingController _roomNameController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _roomPasswordController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();
  bool value = false;

  @override
  void initState() {
    _socketMethods.createRoomSuccessListener(context, ref);
    _socketMethods.createRoomFailListener(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _roomNameController.dispose();
    _gradeController.dispose();
    _subjectController.dispose();
    _roomPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final size = MediaQuery.of(context).size;
    print(user.nickname);
    return Container(
      padding: EdgeInsets.only(top: 13, bottom: 26, left: 26, right: 26),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 26),
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[300],
              ),
            ),
          ),
          Text('방만들기', style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold)),
          SizedBox(height: size.height * 0.04),
          Row(
            children: [
              Text('방    제목',style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
              SizedBox(width: size.height * 0.02),
              Expanded(child: CustomTextField(controller: _roomNameController, hintText: '방 이름을 입력해주세요',)),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: [
              Text('비밀번호',style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
              SizedBox(width: size.height * 0.02),
              buildSwitch(),
              value ? Expanded(child: CustomTextField(controller: _roomPasswordController, hintText: '네 자릿수를 입력하세요',)) : SizedBox.shrink(),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: [
              Text('학       년',style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
              SizedBox(width: size.height * 0.02),
              Expanded(child: CustomTextField(controller: _gradeController, hintText: '학년을 입력해주세요',)),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: [
              Text('과       목',style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
              SizedBox(width: size.height * 0.02),
              Expanded(child: CustomTextField(controller: _subjectController, hintText: '과목 명을 입력해주세요',)),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
            child: Divider(
                height: 1.0,
                thickness: 0.3,
                color: Colors.grey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('모       드',style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
              SizedBox(width: size.height * 0.02),
              Text('(최대 인원은 5명입니다.)', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: Colors.grey[400])),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Text('O/X 퀴즈', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
          SizedBox(height: size.height * 0.02),
          Container(
            width: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: Image.network(
                'https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/quiz.jpg',
                fit: BoxFit.fill,
                key: ValueKey('https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/quiz.jpg'),
              ), // Text(key['title']),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          CustomButton(onTap: () => _socketMethods.createRoom(user.nickname!, _roomNameController.text, _gradeController.text, _subjectController.text), title: '확인'),
        ],
      ),
    );
  }

  Widget buildSwitch() => Container(
    child: FlutterSwitch(
      value: value,
      activeColor: bgColor,
      inactiveColor: Colors.grey[200]!,
      onToggle: (val) {
        setState(() {
          value = val;
        });
      },
    ),
  );
}
