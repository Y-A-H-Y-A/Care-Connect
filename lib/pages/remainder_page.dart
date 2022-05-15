import 'package:flutter/material.dart';

import '../custom_style.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reminders',
          style: CustomTextStyle.style(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomColors.primaryNormalBlue,
      ),
      body: Center(
        child: Text(
          'Reminders',
          style: CustomTextStyle.style(
            fontSize: 60,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
