import 'package:care_connect/pages/search_page.dart';
import 'package:flutter/material.dart';

import '../custom_style.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.primaryLightBlue,
        onPressed: () {
          Navigator.pushNamed(context, SearchPage.pageRout);
        },
        child: const Icon(Icons.search),
      ),
      appBar: AppBar(
        title: Text(
          'Messages',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Messages',
              style: CustomTextStyle.style(
                fontSize: 60,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
