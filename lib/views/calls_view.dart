import 'package:chat_app/components/call_tile.dart';
import 'package:chat_app/components/contact_tile.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/call_model.dart';
import 'package:chat_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CallsView extends StatelessWidget {
  const CallsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Calls", style: TextStyle(color: Colors.white)),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color.fromARGB(146, 255, 255, 255),
                width: 1,
              ),
            ),
            child: Icon(Icons.search, color: Colors.white),
          ),
        ),
        actions: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),

              border: Border.all(
                color: const Color.fromARGB(146, 255, 255, 255),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.add_ic_call_outlined,
              color: Colors.white,
              size: 26,
            ),
          ),
        ],
      ),
      body: DraggableScrollableSheet(
        initialChildSize: 0.95,
        minChildSize: 0.95,
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
                Text(
                  "Recent",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseServices.getCalls(user!.uid),
                    builder: (context, Snapshot) {
                      if (Snapshot.hasError) {
                        print('ERROR: ${Snapshot.error}'); // مهم جدًا
                        return Center(child: Text("there was an error"));
                      }

                      if (Snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final docs = Snapshot.data!.docs;

                      if (docs.isEmpty) {
                        return Center(child: Text("there are no calls"));
                      }

                      final calls = docs
                          .map((d) => CallModel.fromJson(d))
                          .toList();

                      return ListView.builder(
                        controller: ScrollController,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: calls.length,
                        itemBuilder: (context, index) {
                          return CallTile(
                            imageUrl:
                                "https://tse4.mm.bing.net/th/id/OIP.9_MptOLxjJEGSGukPt9FWQHaHa?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
                            name: "John Abraham",
                            time: calls[index].time,
                            isAnswered: calls[index].isAnswered,
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
    );
  }
}
