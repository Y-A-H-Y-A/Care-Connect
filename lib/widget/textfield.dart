import 'package:flutter/material.dart';

import '../custom_style.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {Key? key,
      required this.isobscureText,
      required this.hintText,
      required this.lableText,
      required this.myController})
      : super(key: key);

  final String hintText;
  final String lableText;
  final bool isobscureText;
  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
        height: 48,
        width: 294,
        child: TextFormField(
          obscureText: isobscureText,
          onChanged: (value) {
            myController.text = value;
          },
          //textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10),

            hintText: hintText,
            labelText: lableText,
            labelStyle: CustomTextStyle.style(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.black.withOpacity(0.8)),

            //**Borders */
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.white,
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: CustomColors.primaryLightBlue, width: 3.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
