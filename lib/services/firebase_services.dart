import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/contacts_model.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/views/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  static String getChatId(String uid1, String uid2) {
    final ids = [uid1, uid2];
    ids.sort();
    return ids.join('_');
  }

  static Future<String> signup(String email, String password) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return credential.user!.uid;
  }

  static Future<String> login(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user!.uid;
  }

  static Future<void> addmessage(
    MessageModel message,
    String uid1,
    String uid2,
    ChatModel chat,
  ) async {
    final db = FirebaseFirestore.instance;
    final chatRef = db.collection("chats").doc(getChatId(uid1, uid2));
    final msgRef = chatRef.collection("messages").doc();
    final batch = db.batch();

    final messageMap = <String, dynamic>{
      "data": message.data,
      "to": message.to,
      "from": message.from,
      "isRead": false,
      "time": FieldValue.serverTimestamp(),
    };
    final chatMap = <String, dynamic>{
      "members": chat.members,
      "lastMessage": chat.lastMessage,
      "lastMessageTime": FieldValue.serverTimestamp(),
      "lastMessageFrom": chat.lastMessageFrom,
      "isRead": false,
    };
    batch.set(chatRef, chatMap, SetOptions(merge: true));
    batch.set(msgRef, messageMap, SetOptions(merge: true));

    await batch.commit();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> readData() async {
    final db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> data = await db
        .collection("messages")
        .get();
    return data;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> readStreamData(
    String uid1,
    String uid2,
  ) {
    final db = FirebaseFirestore.instance;
    Stream<QuerySnapshot<Map<String, dynamic>>> data = db
        .collection("chats")
        .doc(getChatId(uid1, uid2))
        .collection('messages')
        .orderBy("time", descending: true)
        .snapshots();
    return data;
  }

  static Stream<List<List<Map<String, dynamic>>>> readStreamMessages(
    String uid,
  ) {
    final db = FirebaseFirestore.instance;

    return db
        .collection("chats")
        .where("members", arrayContains: uid)
        .orderBy("lastMessageTime", descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
          List<List<Map<String, dynamic>>> chats = [];

          for (final doc in snapshot.docs) {
            final chatMap = Map<String, dynamic>.from(doc.data());
            chatMap["id"] = doc.id;

            final members = List<String>.from(chatMap["members"]);
            final otherUid = members.firstWhere((id) => id != uid);

            final userDoc = await db.collection("users").doc(otherUid).get();
            final userMap = Map<String, dynamic>.from(userDoc.data() ?? {});
            userMap["id"] = otherUid;

            chats.add([chatMap, userMap]);
          }

          return chats;
        });
  }

  static void addUser(UserModel user) {
    Map<String, dynamic> userData = {
      "name": user.name,
      "email": user.email,
      "profilePic": user.profilePic,
      "isOnline": user.isOnline,
      "hasStory": user.hasStory,
    };
    final db = FirebaseFirestore.instance;

    db.collection("users").doc(user.uid).set(userData);
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUser(
    String id,
  ) async {
    final db = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> data = await db
        .collection("users")
        .doc(id)
        .get();

    return data;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCalls(String uid) {
    return FirebaseFirestore.instance
        .collection("calls")
        .where("participants", arrayContains: uid)
        .orderBy("time", descending: true)
        .snapshots();
  }

  //add contact(get uid , add to collection)
  // get contacts (get uid and name , get other data from users)
  static Future<List<Map<String, dynamic>>> getContacts(String id) async {
    final contactSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("contacts")
        .get();
    List<Map<String, dynamic>> contactsData = [];
    for (final doc in contactSnapshot.docs) {
      final userName = doc.data()["name"];
      final userId = doc.id;
      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();
      final userData = userDoc.data();
      contactsData.add({
        "name": userName,
        "id": userId,
        "profilePic": userData?["profilePic"],
        "quote": userData?["quote"],
      });
    }
    return contactsData;
  }

  static Future<bool> addContact(String email, String name) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (result.docs.isEmpty) {
      return false;
    }
    final contactId = result.docs.first.id;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('contacts')
        .doc(contactId)
        .set({"name": name});
    return true;
  }
}
