import 'package:bom_front/utils/colors.dart';
import 'package:flutter/material.dart';

import 'box_shadow.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;

    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(10.0),
          height: 50.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: bgColor,
            boxShadow: boxShadow,
            borderRadius: BorderRadius.circular(25.0),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white
            ),
          ),
        ));
  }
}