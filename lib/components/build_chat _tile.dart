import 'package:chat_app/components/profile_pic.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/contacts_model.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BuildChatTile extends StatelessWidget {
  ContactsModel contact;
  ChatModel chat;
  int unreadCount = 1;

  BuildChatTile({super.key, required this.contact, required this.chat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatView(contact: contact, isOnline: true),
          ),
        );
      },
      child: Slidable(
        key: ValueKey(contact.uid),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            CustomSlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.transparent,

              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 60,
                width: 60,
                child: Center(
                  child: Icon(Icons.notifications, color: Colors.white),
                ),
              ),
            ),

            CustomSlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.transparent,

              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 60,
                width: 60,
                child: Center(child: Icon(Icons.delete, color: Colors.white)),
              ),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfilePic(imageUrl: contact.profilePic, isOnline: true),
                SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        chat.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ),

                // الوقت والـ badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      chat.lastMessageTime.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    if (unreadCount > 0)
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$unreadCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
