import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/views/home_view.dart';
import 'package:chat_app/views/onbourding_view.dart';
import 'package:chat_app/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'firebase_options.dart';

UserModel? user;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnbourdingView(),
    );
  }
}
