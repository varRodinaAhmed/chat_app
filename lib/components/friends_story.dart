import 'package:flutter/material.dart';

class FriendsStory extends StatelessWidget {
  const FriendsStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Container(
        height: 70,
        padding: EdgeInsets.all(8),

        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.indigoAccent, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(35),
          child: Image.network(
            "https://tse4.mm.bing.net/th/id/OIP.9_MptOLxjJEGSGukPt9FWQHaHa?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
          ),
        ),
      ),
    );
  }
}
