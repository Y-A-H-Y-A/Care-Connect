import 'package:care_connect/pages/patient_pages/patient_main_page.dart';
// import 'package:care_connect/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_style.dart';
import '../model/users_data.dart';
import '../services/auth_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const String pageRout = 'search_page';
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Map<String, dynamic>? userMap;
  final TextEditingController _search = TextEditingController();

  bool isLoading = false;
  late final FirebaseAuth _auth = FirebaseAuth.instance;

  onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where('email', isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
    });

    print(userMap);
  }
/* 
  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods
          .getDoctorbyDoctorName(searchEditingController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  } */

  Widget userList() {
    return userMap != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return userTile(userMap?['username'], userMap?['specialty']);
            })
        : Container();
  }

  Widget userTile(
    dynamic doctorname,
    dynamic specialty,
  ) {
    return Container(
      color: Color.fromARGB(255, 200, 210, 218),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctorname,
                style: CustomTextStyle.style(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(specialty,
                  style: CustomTextStyle.style(
                      fontSize: 18,
                      color: Color.fromARGB(255, 29, 1, 130),
                      fontWeight: FontWeight.w600)),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(_auth.currentUser!.uid)
                  .collection('doctors')
                  .add({
                    "doctorname": userMap!['username'],
                    "specialty": userMap!['specialty'],
                    "imageurl": userMap!['image'],
                  })
                  .whenComplete(
                    () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Done'),
                            content: Text('Add Success'),
                            actions: <Widget>[
                              ElevatedButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, PatientMainPage.pageRout);
                                },
                              ),
                            ],
                          );
                        }),
                  )
                  .whenComplete(() async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userMap!['uid'])
                        .collection('patient')
                        .add({
                      'patientemail': _auth.currentUser!.email,
                      'patientId': _auth.currentUser!.uid
                    });
                  });
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(24)),
                  child: Icon(
                    CustomIcons.add_new_doctor,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'add',
                  style: CustomTextStyle.style(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

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
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    color: CustomColors.primaryDarkBlue,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _search,
                            style: CustomTextStyle.style(
                                fontSize: 20, color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "search username ...",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            onSearch();
                          },
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        const Color(0x36FFFFFF),
                                        Colors.blue,
                                      ],
                                      begin: FractionalOffset.topLeft,
                                      end: FractionalOffset.bottomRight),
                                  borderRadius: BorderRadius.circular(40)),
                              padding: EdgeInsets.all(12),
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  userList()
                ],
              ),
            ),
    );
  }
}
