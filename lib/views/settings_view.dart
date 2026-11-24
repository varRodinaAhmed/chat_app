import 'package:chat_app/components/contact_tile.dart';
import 'package:chat_app/components/settings_tile.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/views/user_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Settings", style: TextStyle(color: Colors.white)),
      ),
      body: DraggableScrollableSheet(
        initialChildSize: 0.95,
        minChildSize: 0.95,
        maxChildSize: 1,
        builder: (context, ScrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileView(),
                        ),
                      );
                    },
                    child: UserTile(
                      imageUrl: user!.profilePic,
                      name: user!.name,
                      quote: user!.quote ?? "",
                    ),
                  ),
                  Divider(),
                  SettingsTile(
                    icon: Icons.key,
                    title: "Account",
                    subtitle: "Privacy,Security,Change number",
                  ),

                  SettingsTile(
                    icon: Icons.chat,
                    title: "Chat",
                    subtitle: "Chat history,Theme,Wallpaper",
                  ),
                  SettingsTile(
                    icon: Icons.notifications,
                    title: "Notifications",
                    subtitle: "Messages,Groups and others",
                  ),
                  SettingsTile(
                    icon: Icons.help,
                    title: "Help",
                    subtitle: "Help center, Contact us,Privacy policy",
                  ),
                  SettingsTile(
                    icon: Icons.settings_remote_rounded,
                    title: "Storage and Data",
                    subtitle: "Network usage,Storage usage",
                  ),
                  SettingsTile(
                    icon: Icons.person_add_alt_1_rounded,
                    title: "Invite a Friend",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
