import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_style.dart';
import '../services/auth_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const String pageRout = 'search_page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
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
        child: InkWell(
          onTap: () {
            context.read<AthenticationService>().signOut();
          },
          child: Text(
            'Search',
            style: CustomTextStyle.style(
              fontSize: 60,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
