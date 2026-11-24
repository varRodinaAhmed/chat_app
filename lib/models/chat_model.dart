import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  late List<dynamic> members;

  late String lastMessage;
  late DateTime? lastMessageTime;
  bool isRead = false;
  late String lastMessageFrom;
  List<MessageModel> messages = [];

  ChatModel({
    required this.lastMessage,
    required this.lastMessageFrom,
    required this.members,
    required MessageModel message,
  }) {
    messages.add(message);
  }

  ChatModel.fromJson(json) {
    this.lastMessage = json["lastMessage"];
    this.lastMessageTime = (json["lastMessageTime"] as Timestamp?)?.toDate();
    this.lastMessageFrom = json["lastMessageFrom"];
    this.members = json["members"];
    this.isRead = json["isRead"];
    this.messages = json["messages"] ?? [];
  }
}
