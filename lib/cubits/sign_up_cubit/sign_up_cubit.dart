import 'dart:developer';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/cubits/sign_up_cubit/sign_up_states.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());
  void signup(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    if (password == confirmPassword) {
      emit(SignUpLoadingState());
      try {
        String id = await FirebaseServices.signup(email, password);
        user = UserModel(
          uid: id,
          name: name,
          email: email,
          profilePic:
              "https://static.vecteezy.com/system/resources/previews/019/896/012/large_2x/female-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png",
          isOnline: true,
          hasStory: false,
        );
        FirebaseServices.addUser(user!);

        emit(SignUpSuccessState());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          log('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          log('The account already exists for that email.');
        }
        emit(SignUpFailureState(e.code));
      } catch (e) {
        log(e.toString());
        emit(SignUpFailureState(e.toString()));
      }
    } else {
      log('password not identical');
      emit(SignUpFailureState('password not identical'));
    }
  }
}
