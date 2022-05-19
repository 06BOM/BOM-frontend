import 'package:bom_front/utils/colors.dart';
import 'package:flutter/material.dart';

import '../network/socket_method.dart';
import 'components/quiz/custom_button.dart';
import 'components/quiz/custom_text.dart';
import 'components/quiz/custom_textfield.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.createRoomSuccessListener(context);
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
                    color: bgColor,
                  ),
                ],
                text: '방 만들기',
                fontSize: 70,
              ),
              SizedBox(height: size.height * 0.08),
              CustomTextField(controller: _nickNameController,
                hintText: '닉네임을 입력해주세요',),
              SizedBox(height: size.height * 0.02),
              CustomTextField(controller: _roomNameController,
                hintText: '방 이름을 입력해주세요',),
              SizedBox(height: size.height * 0.03),
              CustomButton(onTap: () => _socketMethods.createRoom(_nickNameController.text, _roomNameController.text), title: '생성'),
            ],
          ),
        ),
      );
  }
}