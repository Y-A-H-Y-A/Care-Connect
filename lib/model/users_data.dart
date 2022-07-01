import 'package:flutter/material.dart';

class Var {
  static DateTime? dateofbirth;
  static bool isMalePressed = false;
  static bool isFemalePressed = false;
  static bool isDoctor = false;
  static bool isPatient = false;
  static String gender = '';
  static TextEditingController fullNameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController searchController = TextEditingController();
  static const String role = 'patient';
}

class Doctor {
  final String doctorname;
  final String image;
  final String specialty;

  Doctor({
    required this.doctorname,
    required this.image,
    required this.specialty,
  });

  Map<String, dynamic> toJson() =>
      {'doctorname': doctorname, 'imageurl': image, 'specialty': specialty};

  static Doctor fromJson(Map<String, dynamic> json) => Doctor(
      doctorname: json['doctorname'],
      image: json['imageurl'],
      specialty: json['specialty']);
}

class Patient {
  final String patientname;
  final String patientId;

  Patient({required this.patientId, required this.patientname});

  Map<String, dynamic> toJson() => {
        'patientemail': patientname,
        'patientId': patientId,
      };

  static Patient fromJson(Map<String, dynamic> json) => Patient(
        patientname: json['patientemail'],
        patientId: json['patientId'],
      );
}
