import 'package:care_connect/custom_style.dart';
import 'package:care_connect/pages/setting_page.dart';
import 'package:flutter/material.dart';

import 'messages_page.dart';
import 'remainder_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String pageRout = 'testingPage';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //*The first page is always the Messages page */
  int currentIndex = 0;
  final pages = [
    const MessagesPage(),
    const ReminderPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!We put the pages in an IndexedStack widget to keep the state
      //! of a page even after navigating to another page
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        backgroundColor: CustomColors.primaryNormalBlue,
        selectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          //*Messages */
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble,
              size: 37,
            ),
            backgroundColor: CustomColors.primaryLightBlue,
            label: 'Messages',
          ),
          //*Reminder */
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.care_connect_heart,
              size: 40,
            ),
            backgroundColor: CustomColors.primaryLightBlue,
            label: 'Reminders',
          ),
          //*Settings */
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 37,
            ),
            backgroundColor: CustomColors.primaryLightBlue,
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
