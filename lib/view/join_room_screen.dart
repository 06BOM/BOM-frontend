import 'package:flutter/material.dart';

import '../network/socket_method.dart';
import 'components/quiz/custom_button.dart';
import 'components/quiz/custom_text.dart';
import 'components/quiz/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';

  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updateRoomListener(context);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nickNameController.dispose();
    _roomNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: Colors.blue,
                  ),
                ],
                text: '방 참여하기',
                fontSize: 70,
              ),
              SizedBox(height: size.height * 0.08),
              CustomTextField(
                controller: _nickNameController,
                hintText: '닉네임을 입력해주세요',
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: _roomNameController,
                hintText: '방 이름을 입력해주세요',
              ),
              SizedBox(height: size.height * 0.03),
              CustomButton(
                  // onTap: () => _socketMethods.joinRoom(
                  //     _nickNameController.text, _roomNameController.text),
                  onTap: () => _socketMethods.joinRoom(
                      _nickNameController.text, _roomNameController.text),
                  title: '참여'),
            ],
          ),
        ),
      );
  }
}