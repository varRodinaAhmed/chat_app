import 'package:chat_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  late String data;
  late String from;
  late String to;
  late DateTime? time;
  late bool isRead;
  late bool isSender;

  MessageModel({
    required this.data,
    required this.from,
    required this.to,
    required this.isRead,
    this.time,
  }) {
    if (this.from == user!.uid) {
      this.isSender = true;
    } else {
      this.isSender = false;
    }
  }
  MessageModel.fromJson(json) {
    this.data = json["data"];
    this.from = json["from"];
    this.to = json["to"];
    this.time = (json["time"] as Timestamp?)?.toDate();
    this.isRead = json["isRead"];
    if (this.from == user!.uid) {
      this.isSender = true;
    } else {
      this.isSender = false;
    }
  }
}
