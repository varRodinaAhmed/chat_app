import 'package:flutter/material.dart';

class dividerWidget extends StatelessWidget {
  Color? color;
  dividerWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Divider(indent: 10, endIndent: 10, color: color)),
        Text('OR', style: TextStyle(color: color)),
        Expanded(child: Divider(indent: 10, endIndent: 10, color: color)),
      ],
    );
  }
}
