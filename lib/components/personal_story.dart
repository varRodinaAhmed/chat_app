import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';

class PersonalStory extends StatelessWidget {
  const PersonalStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Stack(
        alignment: AlignmentGeometry.bottomRight,
        children: [
          Container(
            height: 90,
            padding: EdgeInsets.all(7),

            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
              border: user!.hasStory
                  ? Border.all(color: Colors.indigoAccent, width: 1)
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(35),
              child: Image.network(user!.profilePic),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
