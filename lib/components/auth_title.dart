import 'package:flutter/material.dart';

class authTitle extends StatelessWidget {
  String text;
  double top;
  double left;
  authTitle({
    super.key,
    required this.text,
    required this.left,
    required this.top,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentGeometry.topCenter,
          children: [
            Positioned(
              top: top,
              left: left,
              child: Container(color: Colors.teal, height: 12, width: 55),
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
