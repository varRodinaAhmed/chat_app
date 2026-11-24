import 'package:chat_app/components/action_text.dart';
import 'package:chat_app/components/auth_title.dart';
import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_textfield.dart';
import 'package:chat_app/components/divider_widget.dart';
import 'package:chat_app/components/icons_row.dart';
import 'package:chat_app/cubits/log_in_cubit/log_in_cubit.dart';
import 'package:chat_app/cubits/log_in_cubit/log_in_states.dart';
import 'package:chat_app/views/home_view.dart';
import 'package:chat_app/views/sign_up_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LogInView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInCubit(),
      child: BlocListener<LogInCubit, LogInStates>(
        listener: (context, state) {
          if (state is LogInSuccessState) {
            Get.snackbar('Success', "log in done successfully");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
            );
          } else if (state is LogInFailureState) {
            Get.snackbar('Error', state.errMsg);
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
                    authTitle(text: 'Log in to Chatbox', left: 1, top: 19),
                    SizedBox(height: 16),
                    Text(
                      'Welcome back! Sign in using your social',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    Text(
                      'account or email to continue us',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(height: 30),

                    iconsRow(lightMode: false),
                    SizedBox(height: 30),

                    dividerWidget(color: Colors.grey),
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
                    SizedBox(height: 150),

                    BlocBuilder<LogInCubit, LogInStates>(
                      builder: (context, state) {
                        final cubit = context.read<LogInCubit>();
                        if (state is LogInLoadingState) {
                          return CircularProgressIndicator();
                        }
                        return customButton(
                          onTapFun: () async {
                            if (_formKey.currentState!.validate()) {
                              cubit.login(email, password);
                            } else {
                              print('Wrong data.');
                            }
                          },
                          buttonColor: Colors.teal,
                          textColor: Colors.white,
                          title: "Log in",
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    actionText(
                      text1: 'don\'t have an account? ',
                      text2: "Sign up",
                      color: Colors.teal,
                      ontapFun: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpView()),
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
