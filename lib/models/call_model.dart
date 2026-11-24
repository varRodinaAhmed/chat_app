import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CallModel {
  late String from;
  late String to;
  late bool isAnswered;
  late String time;
  late List<dynamic> participants;
  CallModel({
    required this.to,
    required this.from,
    required this.isAnswered,
    required this.time,
    required this.participants,
  });
  CallModel.fromJson(json) {
    this.to = json["to"];
    this.from = json["from"];
    this.isAnswered = json["isAnswered"];
    this.time = timeToSrting(json["time"]);
    this.participants = json["participants"];
  }
}

String timeToSrting(Timestamp time) {
  final date = time.toDate();
  return DateFormat('dd/MM/yyyy, hh:mm a').format(date);
}
