import 'package:flutter/material.dart';

class iconWidget extends StatelessWidget {
  String imageUrl;
  Color borderColor;
  Color? iconColor;

  iconWidget({
    super.key,
    required this.imageUrl,
    required this.borderColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.transparent,

        borderRadius: BorderRadius.circular(45),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Image.asset(imageUrl, fit: BoxFit.fill, color: iconColor),
      ),
    );
  }
}
