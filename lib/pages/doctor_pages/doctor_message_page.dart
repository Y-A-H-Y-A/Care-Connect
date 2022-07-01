import 'package:care_connect/model/users_data.dart';
import 'package:care_connect/pages/chatroom_page.dart';
import 'package:care_connect/pages/search_page.dart';
// import 'package:care_connect/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../custom_style.dart';
//import '../../services/helperfunction.dart';

class DoctorMessagesPage extends StatefulWidget {
  const DoctorMessagesPage({Key? key}) : super(key: key);

  @override
  State<DoctorMessagesPage> createState() => _DoctorMessagesPageState();
}

class _DoctorMessagesPageState extends State<DoctorMessagesPage> {
  late final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Patient>> readPatient() => FirebaseFirestore.instance
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('patient')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Patient.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.primaryNormalBlue,
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
      body: StreamBuilder<List<Patient>>(
        stream: readPatient(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final patient = snapshot.data;

            return ListView(
              children: patient!.map(buildPatient).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }

  Widget buildPatient(
    Patient patient,
  ) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoom(
                chatWithUsername: patient.patientname,
                id: patient.patientId,
              ),
            ),
          );
        },
        child: Container(
          color: Color.fromARGB(255, 14, 64, 134),
          child: ListTile(
            title: Text(
              'P.${patient.patientname.replaceAll('@gmail.com', '')}',
              style: CustomTextStyle.style(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      );
}
