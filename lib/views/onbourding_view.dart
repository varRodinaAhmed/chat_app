import 'package:chat_app/components/action_text.dart';
import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/divider_widget.dart';
import 'package:chat_app/components/icon_widget.dart';
import 'package:chat_app/components/icons_row.dart';
import 'package:chat_app/components/title_and_subtitle.dart';
import 'package:chat_app/views/log_in_view.dart';
import 'package:chat_app/views/sign_up_view.dart';
import 'package:flutter/material.dart';

class OnbourdingView extends StatelessWidget {
  const OnbourdingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/Onboarding_background.jpg",
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                Image.asset("assets/app_logo.png"),
                SizedBox(height: 35),
                titleAndSubtitle(),
                SizedBox(height: 38),

                iconsRow(lightMode: true),
                SizedBox(height: 30),

                dividerWidget(color: Colors.white),
                SizedBox(height: 30),

                customButton(
                  onTapFun: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpView()),
                    );
                  },
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                  title: 'Sign up with mail',
                ),
                SizedBox(height: 30),

                actionText(
                  text1: "Existing account ? ",
                  text2: "Log in ",
                  color: Colors.white,
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
        ],
      ),
    );
  }
}
