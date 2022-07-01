import 'package:care_connect/model/users_data.dart';
import 'package:care_connect/pages/chatroom_page.dart';
import 'package:care_connect/pages/search_page.dart';
// import 'package:care_connect/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../custom_style.dart';
//import '../../services/helperfunction.dart';

class PatientMessagesPage extends StatefulWidget {
  const PatientMessagesPage({Key? key}) : super(key: key);

  @override
  State<PatientMessagesPage> createState() => _PatientMessagesPageState();
}

class _PatientMessagesPageState extends State<PatientMessagesPage> {
  late final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Doctor>> readDoctors() => FirebaseFirestore.instance
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('doctors')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Doctor.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: StreamBuilder<List<Doctor>>(
        stream: readDoctors(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final doctors = snapshot.data;

            return ListView(
              children: doctors!.map(buildDoctor).toList(),
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

  Widget buildDoctor(
    Doctor doctor,
  ) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoom(
                chatWithUsername: doctor.doctorname,
              ),
            ),
          );
        },
        child: ListTile(
          subtitle: Text(
            doctor.specialty,
            style: CustomTextStyle.style(
                fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w600),
          ),
          leading: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 246, 242, 242),
            child: Image.network(
              doctor.image,
            ),
          ),
          title: Text(
            'Dr.${doctor.doctorname}',
            style: CustomTextStyle.style(
                fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
      );
}
