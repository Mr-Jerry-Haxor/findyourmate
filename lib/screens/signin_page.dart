// ignore_for_file: camel_case_types, duplicate_ignore

import 'package:findyourmate/screens/resetpassword_page.dart';
import 'package:findyourmate/screens/signup_page.dart';
import 'package:findyourmate/utils/color_utils.dart';
import 'package:findyourmate/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:findyourmate/screens/home_page.dart';

class SignIn_page extends StatefulWidget {
  const SignIn_page({super.key});

  @override
  State<SignIn_page> createState() => _SignIn_pageState();
}


class _SignIn_pageState extends State<SignIn_page> {
  final TextEditingController _passwordTextController = TextEditingController();
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
                reusableTextField("Enter Email id", Icons.attach_email_outlined, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 10,
                ),
                forgetPassword(context),
                firebaseUIButton(context, "Sign In", () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(child: CircularProgressIndicator());
                  });
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Homepage()));
                  }).onError((error, stackTrace) {
                    // print("Error ${error.toString()}");
                    final snackBar = SnackBar(content: Text(" ${error.toString().split(']')[1].toString()}"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                  Navigator.of(context).pop();
                }),
                signUpOption()
              ]
            ),
          ),
        ),
      )
    );
  }
  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account? ",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Signup_page()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  
  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Resetpassword_page())),
      ),
    );
  }
}
