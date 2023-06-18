// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourmate/screens/home_page.dart';
import 'package:findyourmate/screens/signin_page.dart';
import 'package:findyourmate/utils/color_utils.dart';
import 'package:findyourmate/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup_page extends StatefulWidget {
  const Signup_page({super.key});

  @override
  State<Signup_page> createState() => _Signup_pageState();
}

class _Signup_pageState extends State<Signup_page> {
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _mobile = TextEditingController();
  final _work = TextEditingController();
  final _address = TextEditingController();
  final _skills = TextEditingController();
  final _study = TextEditingController();
  final _projects = TextEditingController();
  final _experience = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _confirmpasswordTextController = TextEditingController();
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
                logoWidget("images/logo2.png"),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Fill your details to Signup",
                  style: TextStyle(fontSize: 30, color: Colors.black38),
                ),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter First name", Icons.person_outline, false,
                    _firstname),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Last name", Icons.person_outline, false,
                    _lastname),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.attach_email_outlined, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter phone number", Icons.phone_android_outlined, false,
                    _mobile),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Student or Job ", Icons.work_history_outlined, false,
                    _work),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter address", Icons.place_outlined, false,
                    _address),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter your skills(separated by comma)", Icons.computer, false,
                    _skills),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter your education details", Icons.book_rounded, false,
                    _study),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter your experience(if any)", Icons.work_history_outlined, false,
                    _experience),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("projects(if any,separated by comma)", Icons.lightbulb_outline_rounded, false,
                    _projects),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Confirm  Password", Icons.lock_outline, true,
                    _confirmpasswordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(child: CircularProgressIndicator());
                  });
                  if (_confirmpasswordTextController.text == _passwordTextController.text) {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                          // add user details
                       FirebaseFirestore.instance.collection("users").doc(_emailTextController.text.trim()).set({
                        "firstname" : _firstname.text.trim(),
                        "lastname" : _lastname.text.trim(),
                        "email" : _emailTextController.text.trim(),
                        "phoneno" : _mobile.text.trim(),
                        "work" : _work.text.trim(),
                        "address" : _address.text.trim(),
                        "skills" : _skills.text.trim(),
                        "study" : _study.text.trim(),
                        "projects" : _projects.text.trim(),
                        "experience" : _experience.text.trim(),
                      });

                      const snackBar = SnackBar(content: Text("Congragulations for creating account"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Homepage()));
                    }).onError((error, stackTrace) {
                      final snackBar = SnackBar(content: Text(" ${error.toString().split(']')[1].toString()}"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  }else {
                    const snackBar = SnackBar(content: Text("Password Mismatching"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                Navigator.of(context).pop();
                }),
                signIpOption(),
                const SizedBox(
                  height: 40,
                ),
              ]
            ),
          ),
        ),
      )
    );
  }

  Row signIpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have account? ",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignIn_page()));
          },
          child: const Text(
            " Sign In",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}