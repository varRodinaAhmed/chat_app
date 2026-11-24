import 'dart:developer';
import 'package:chat_app/components/action_text.dart';
import 'package:chat_app/components/auth_title.dart';
import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_textfield.dart';
import 'package:chat_app/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:chat_app/cubits/sign_up_cubit/sign_up_states.dart';
import 'package:chat_app/services/firebase_services.dart';
import 'package:chat_app/views/home_view.dart';
import 'package:chat_app/views/log_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  String email = '';
  String password = '';
  String name = '';
  String confirmPassword = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocListener<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            Get.snackbar('Success', "Sign up done successfully");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
            );
          } else if (state is SignUpFailureState) {
            Get.snackbar('Error', state.errorMsg);
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    authTitle(text: 'Sign up with email', left: 120, top: 19),
                    SizedBox(height: 16),
                    Text(
                      'Get chatting with friends and family today by',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      'signing up for our chat app!',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(height: 30),
                    customTextfield(
                      title: 'Your name',
                      onSubmitted: (value) {
                        name = value;
                      },
                    ),
                    SizedBox(height: 30),

                    customTextfield(
                      title: 'Your email',
                      onSubmitted: (value) {
                        email = value;
                      },
                    ),
                    SizedBox(height: 30),

                    customTextfield(
                      title: 'Password',
                      obsecure: true,
                      onSubmitted: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(height: 30),

                    customTextfield(
                      title: 'Confirm password',
                      obsecure: true,
                      onSubmitted: (value) {
                        confirmPassword = value;
                      },
                    ),
                    SizedBox(height: 100),
                    BlocBuilder<SignUpCubit, SignUpStates>(
                      builder: (context, state) {
                        final cubit = context.read<SignUpCubit>();
                        if (state is SignUpLoadingState) {
                          return CircularProgressIndicator();
                        }
                        return customButton(
                          onTapFun: () async {
                            if (_formKey.currentState!.validate()) {
                              cubit.signup(
                                name,
                                email,
                                password,
                                confirmPassword,
                              );
                            }
                          },
                          buttonColor: Colors.teal,
                          textColor: Colors.white,
                          title: "Create an account",
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    actionText(
                      text1: 'already have an account? ',
                      text2: "Log in",
                      color: Colors.teal,
                      ontapFun: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LogInView()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
