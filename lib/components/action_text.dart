import 'package:chat_app/views/log_in_view.dart';
import 'package:flutter/material.dart';

class actionText extends StatelessWidget {
  String text1;
  String text2;
  Color color;
  void Function() ontapFun;

  actionText({
    super.key,
    required this.text1,
    required this.text2,
    required this.color,
    required this.ontapFun,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text1, style: TextStyle(color: color)),
        InkWell(
          onTap: ontapFun,
          child: Text(
            text2,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ),
      ],
    );
  }
}
