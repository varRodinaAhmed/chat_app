import 'dart:developer';

import 'package:chat_app/cubits/log_in_cubit/log_in_states.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInCubit extends Cubit<LogInStates> {
  LogInCubit() : super(LogInInitialState());
  void login(String email, String password) async {
    try {
      emit(LogInLoadingState());
      String id = await FirebaseServices.login(email, password);
      DocumentSnapshot data = await FirebaseServices.getUser(id);
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get();

      user = UserModel.fromJson(data.data(), id);
      emit(LogInSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      emit(LogInFailureState(e.code));
    }
  }
}
