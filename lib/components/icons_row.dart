import 'package:chat_app/components/icon_widget.dart';
import 'package:flutter/material.dart';

class iconsRow extends StatelessWidget {
  bool lightMode;
  iconsRow({super.key, required this.lightMode});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconWidget(
          imageUrl: 'assets/facebook_icon.png',
          borderColor: lightMode ? Colors.white : Colors.black,
        ),
        iconWidget(
          imageUrl: 'assets/google_icon.png',
          borderColor: lightMode ? Colors.white : Colors.black,
        ),
        iconWidget(
          imageUrl: 'assets/apple_icon.png',
          borderColor: lightMode ? Colors.white : Colors.black,
          iconColor: lightMode ? null : Colors.black,
        ),
      ],
    );
  }
}
