import 'package:chat_app/components/profile_pic.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/contacts_model.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/services/firebase_services.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ChatView extends StatelessWidget {
  ContactsModel contact;
  bool isOnline;

  final controller = ScrollController();
  ChatView({super.key, required this.contact, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseServices.readStreamData(user!.uid, contact.uid),
      builder: (context, Snapshot) {
        if (Snapshot.hasData) {
          List<MessageModel> messages = [];
          for (int i = 0; i < Snapshot.data!.docs.length; i++) {
            messages.add(MessageModel.fromJson(Snapshot.data!.docs[i]));
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(8, 0, 0, 0),
                          offset: Offset(0, 10),

                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfilePic(
                          imageUrl: contact.profilePic,
                          isOnline: isOnline,
                        ),
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
                              if (isOnline)
                                Text(
                                  "active now",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(width: 50),
                        Icon(Icons.call_outlined),
                        SizedBox(width: 10),
                        Icon(Icons.videocam_outlined),

                        // الوقت والـ badge
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: controller,
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      itemCount: messages.length,
                      itemBuilder: (context, Index) {
                        return Column(
                          children: [
                            BubbleSpecialOne(
                              text: messages[Index].data,
                              isSender: messages[Index].isSender,
                              color: (messages[Index].isSender)
                                  ? Color(0xffF2F7FB)
                                  : Colors.teal,
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: (messages[Index].isSender)
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            SizedBox(height: 2),
                          ],
                        );
                      },
                    ),
                  ),
                  MessageBar(
                    onSend: (value) {
                      MessageModel message = MessageModel(
                        data: value,
                        from: user!.uid,
                        to: contact.uid,
                        isRead: false,
                      );

                      ChatModel chat = ChatModel(
                        lastMessage: message.data,
                        lastMessageFrom: user!.uid,
                        members: [user!.uid, contact.uid],
                        message: message,
                      );
                      FirebaseServices.addmessage(
                        message,
                        user!.uid,
                        contact.uid,
                        chat,
                      );
                      controller.animateTo(
                        0,
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    actions: [
                      InkWell(
                        child: Icon(Icons.add, color: Colors.black, size: 24),
                        onTap: () {},
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: InkWell(
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.green,
                            size: 24,
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (Snapshot.hasError) {
          print('ERROR: ${Snapshot.error}');
          return Scaffold(body: Center(child: Text("there was an error")));
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
