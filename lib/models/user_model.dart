import 'package:chat_app/models/contacts_model.dart';

class UserModel {
  late String uid;
  late String name;
  late String email;
  late String profilePic;
  late bool isOnline;
  late bool hasStory;
  List<ContactsModel> contacts = [];
  String? quote;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePic,
    required this.isOnline,
    required this.hasStory,
  });
  UserModel.fromJson(json, id) {
    this.email = json["email"];
    this.name = json["name"];
    this.quote = json["quote"];
    this.profilePic = json["profilePic"];
    this.isOnline = json["isOnline"];
    this.hasStory = json["hasStory"];
    this.uid = id;
  }
}
