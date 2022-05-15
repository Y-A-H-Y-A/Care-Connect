import 'package:care_connect/pages/main_page.dart';
import 'package:care_connect/services/auth_warpper.dart';
import 'package:care_connect/widget/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_style.dart';
import '../model/users_data.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const String pageRout = 'sign_up';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Color? selectedColor = Colors.black;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        Var.dateofbirth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Image.asset(
              'assets/images/logo2.png',
              width: 321,
            ),
            const SizedBox(height: 41),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Create a new Account :',
                  style: CustomTextStyle.style(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //**Full Name */
            MyTextField(
              myController: Var.fullNameController,
              lableText: ' Full Name',
              hintText: '',
              isobscureText: false,
            ),

            //**Email */
            MyTextField(
              myController: Var.emailController,
              lableText: ' Email',
              hintText: ' someone@example.com',
              isobscureText: false,
            ),

            //**Password */
            MyTextField(
              myController: Var.passwordController,
              lableText: ' Password',
              hintText: ' 13aDah!#',
              isobscureText: true,
            ),

            //!Using the {Custom TextFormField}

            //******************************** */

            const SizedBox(height: 25),
            //*Date of birth & Gender */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date of birth:',
                      style: CustomTextStyle.style(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                        height: 45,
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            side:
                                const BorderSide(color: Colors.black, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                            ),
                          ),
                          onPressed: () async {
                            _selectDate(context);
                          },
                          child: Text(
                              '${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}',
                              textAlign: TextAlign.center,
                              style: CustomTextStyle.style(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              )),
                        )),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Gender:',
                      style: CustomTextStyle.style(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              Var.isMalePressed = false;
                              Var.isFemalePressed = !Var.isFemalePressed;
                              Var.gender = 'male';
                            });
                          },
                          icon: Icon(
                            Icons.male,
                            color: (Var.isFemalePressed)
                                ? Colors.blue
                                : Colors.black45,
                            size: 50,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              Var.isMalePressed = !Var.isMalePressed;
                              Var.isFemalePressed = false;
                              Var.gender = 'female';
                            });
                          },
                          icon: Icon(
                            Icons.female,
                            color: (Var.isMalePressed)
                                ? Colors.pink
                                : Colors.black45,
                            size: 50,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),

            const SizedBox(height: 100),
            //*The Sign Up button
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(4, 4),
                    )
                  ]),
              height: 54,
              width: 294,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: CustomColors.primaryNormalBlue,
                ),
                onPressed: () {
                  try {
                    final String email = Var.emailController.text.trim();
                    final String password = Var.passwordController.text.trim();
                    final String userName = Var.fullNameController.text.trim();
                    if (email.isEmpty) {
                      print('Email is Empty');
                    } else {
                      if (password.isEmpty) {
                        print('Password is Empty');
                      } else {
                        context
                            .read<AthenticationService>()
                            .signup(
                              email: email,
                              password: password,
                            )
                            .then((value) async {
                          User? user = FirebaseAuth.instance.currentUser;

                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(user?.uid)
                              .set({
                            'uid': user?.uid,
                            'email': email,
                            'password': password,
                            'username': userName,
                            'gender': Var.gender,
                            'date_of_birth':
                                '${Var.dateofbirth!.year} - ${Var.dateofbirth!.month} - ${Var.dateofbirth!.day}',
                            'role': Var.role,
                          });
                        });
                      }
                    }
                  } catch (e) {
                    print(e.toString());
                    // TODO
                  }
                  Navigator.pushReplacementNamed(
                      context, AuthenticationWapper.pageRout);
                },
                child: Text(
                  'Sign Up',
                  style: CustomTextStyle.style(
                    fontSize: 19,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: CustomTextStyle.style(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Login.pageRout);
                  },
                  child: Text(
                    'Sign in',
                    style: CustomTextStyle.style(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      color: CustomColors.primaryNormalBlue,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
