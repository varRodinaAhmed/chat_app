import 'package:chat_app/components/contact_tile.dart';
import 'package:chat_app/components/custom_alert_dialog.dart';
import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_textfield.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/contacts_model.dart';
import 'package:chat_app/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsView extends StatefulWidget {
  ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Contacts", style: TextStyle(color: Colors.white)),
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
            child: InkWell(
              onTap: () async {
                final added = await showDialog<bool>(
                  context: context,
                  builder: (_) => CustomAlertDialog(),
                );

                if (added == true) setState(() {});
              },
              child: Icon(Icons.person_add_alt, color: Colors.white, size: 30),
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
                  "Contacts",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FutureBuilder(
                  future: FirebaseServices.getContacts(user!.uid),
                  builder: (context, Snapshot) {
                    if (Snapshot.hasError) {
                      return Center(child: Text("there was an error"));
                    }
                    if (Snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    if (!Snapshot.hasData) {
                      return Center(child: Text("you have no contacts"));
                    }
                    user!.contacts = [];
                    for (var i = 0; i < Snapshot.data!.length; i++) {
                      user!.contacts.add(
                        ContactsModel.fromJson(Snapshot.data![i]),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        controller: ScrollController,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: user!.contacts.length,
                        itemBuilder: (context, index) {
                          return ContactTile(contact: user!.contacts[index]);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
