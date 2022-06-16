import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isReadOnly;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   boxShadow: [
      //     BoxShadow(
      //       color: bgColor,
      //       blurRadius: 5,
      //       spreadRadius: 2,
      //     )
      //   ],
      // ),
      child: TextField(
        readOnly: isReadOnly,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Color(0xFFF4F6F9),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xFF8F9BB3)),
        ),
      ),
    );
  }
}