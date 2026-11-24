import 'package:chat_app/components/friends_story.dart';
import 'package:chat_app/components/personal_story.dart';
import 'package:flutter/material.dart';

class StoriesRow extends StatelessWidget {
  const StoriesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,

      child: ListView.builder(
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return PersonalStory();
          }
          return FriendsStory();
        },
      ),
    );
  }
}
