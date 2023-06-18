// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:findyourmate/screens/signin_page.dart';
import 'package:findyourmate/utils/color_utils.dart';
import 'package:findyourmate/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Resetpassword_page extends StatefulWidget {
  const Resetpassword_page({super.key});

  @override
  State<Resetpassword_page> createState() => _Resetpassword_pageState();
}

class _Resetpassword_pageState extends State<Resetpassword_page> {
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height : MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:  [
                hexStringToColor("93acf8"),
                hexStringToColor("2e68ff")
              ] , begin: Alignment.topCenter , end: Alignment.bottomCenter
            )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("images/logo1.png"),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Email Id", Icons.attach_email_outlined, false,
                    _emailTextController),
                const SizedBox(
                  height: 10,
                ),
                Passwordknown(context),
                firebaseUIButton(context, "Reset Password", () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailTextController.text)
                      .then((value){
                        const snackBar = SnackBar(content: Text("Reset link sent to the email"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pop();
                      }).onError((error, stackTrace) {
                    // print("Error ${error.toString()}");
                    final snackBar = SnackBar(content: Text(" ${error.toString().split(']')[1].toString()}"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                })
              ]
            ),
          ),
        ),
      )
    );
  }
  Widget Passwordknown(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Back to Login  ",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignIn_page())),
      ),
    );
  }
}