import 'package:chat_app/components/build_chat%20_tile.dart';
import 'package:chat_app/components/stories_row.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/contacts_model.dart';
import 'package:chat_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class MessagesView extends StatelessWidget {
  MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("Home", style: TextStyle(color: Colors.white)),
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Icon(Icons.search, color: Colors.white),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Image.network(user!.profilePic),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(children: [StoriesRow()]),
            DraggableScrollableSheet(
              initialChildSize: 0.82,
              minChildSize: 0.82,
              maxChildSize: 1,
              builder: (context, ScrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 8),
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: FirebaseServices.readStreamMessages(
                            user!.uid,
                          ),
                          builder: (context, Snapshot) {
                            if (Snapshot.hasError) {
                              print('ERROR: ${Snapshot.error}');
                              return Center(child: Text("there was an error"));
                            }

                            if (Snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final items = Snapshot.data!;

                            if (items.isEmpty) {
                              return Center(
                                child: Text("there are no messages"),
                              );
                            }

                            return ListView.builder(
                              controller: ScrollController,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final userMap = items[index][1];

                                final contact = ContactsModel.fromJson({
                                  "id": userMap["id"],
                                  "name": userMap["name"] ?? "",
                                  "profilePic": userMap["profilePic"] ?? "",
                                  "quote": userMap["quote"] ?? "",
                                });

                                return BuildChatTile(
                                  chat: ChatModel.fromJson(items[index][0]),
                                  contact: contact,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
