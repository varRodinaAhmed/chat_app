import 'package:flutter/material.dart';

class titleAndSubtitle extends StatelessWidget {
  const titleAndSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect\nfriends',
          style: TextStyle(color: Colors.white, fontSize: 68, height: 1.2),
        ),
        Text(
          'easily &\nquickly',
          style: TextStyle(
            color: Colors.white,
            fontSize: 68,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        SizedBox(height: 16),

        Text(
          'Our chat App is the perfect way to stay connected with your friends & family',
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
