import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  Color buttonColor;
  Color textColor;
  String title;
  void Function() onTapFun;

  customButton({
    super.key,
    required this.buttonColor,
    required this.textColor,
    required this.title,
    required this.onTapFun,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFun,
      child: Container(
        height: 48,
        width: 327,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
