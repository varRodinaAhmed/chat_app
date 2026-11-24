import 'package:chat_app/models/contacts_model.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  final ContactsModel contact;

  const ContactTile({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //open chat page
        // call getchat and messages from firebase services
        // store the uid of the contact and pass it as parameter to the chatpage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatView(contact: contact, isOnline: true),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(contact.profilePic),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    contact.quote,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
