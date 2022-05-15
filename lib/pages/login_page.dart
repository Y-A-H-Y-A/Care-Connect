import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_style.dart';
import '../model/users_data.dart';
import '../services/auth_service.dart';
import '../widget/textfield.dart';
import 'signup_page.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  static const String pageRout = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            Image.asset(
              'assets/images/logo2.png',
              width: 321,
            ),
            const SizedBox(
              height: 47,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Login to your Account',
                  style: CustomTextStyle.style(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 29,
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
              hintText: '',
              isobscureText: true,
            ),
            const SizedBox(
              height: 45,
            ),
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
                  final String email = Var.emailController.text.trim();
                  final String password = Var.passwordController.text.trim();
                  if (email.isEmpty) {
                    print('Email is Empty');
                  } else {
                    if (password.isEmpty) {
                      print('Password is Empty');
                    }
                  }
                  context.read<AthenticationService>().login(
                        email: email,
                        password: password,
                      );
                },
                child: Text(
                  'Sign in',
                  style: CustomTextStyle.style(
                    fontSize: 19,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have an account?',
                    style: CustomTextStyle.style(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.5),
                    )),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUp.pageRout);
                  },
                  child: Text('Sign up',
                      style: CustomTextStyle.style(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        color: CustomColors.primaryNormalBlue,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
