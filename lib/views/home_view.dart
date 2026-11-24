import 'package:chat_app/components/build_chat%20_tile.dart';
import 'package:chat_app/components/icons_row.dart';
import 'package:chat_app/components/stories_row.dart';
import 'package:chat_app/views/calls_view.dart';
import 'package:chat_app/views/contacts_view.dart';
import 'package:chat_app/views/messages_view.dart';
import 'package:chat_app/views/settings_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currnetIndex = 0;
  List<Widget> views = [
    MessagesView(),
    CallsView(),
    ContactsView(),
    SettingsView(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(index: currnetIndex, children: views),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currnetIndex,
          onTap: (index) => setState(() {
            currnetIndex = index;
          }),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF0F6E56),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded),
              label: "Messages",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call_outlined),
              label: "Calls",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: "Contacts",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
