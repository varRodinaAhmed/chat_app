class ContactsModel {
  late String name;
  late String quote;
  late String profilePic;
  late String uid;
  ContactsModel({
    required this.name,
    required this.quote,
    required this.profilePic,
    required this.uid,
  });
  ContactsModel.fromJson(json) {
    name = json["name"].toString();
    quote = (json["quote"] ?? "").toString();
    profilePic =
        (json["profilePic"] ??
                "https://tse4.mm.bing.net/th/id/OIP.9_MptOLxjJEGSGukPt9FWQHaHa?r=0&rs=1&pid=ImgDetMain&o=7&rm=3")
            .toString();
    uid = json["id"].toString();
  }
}
