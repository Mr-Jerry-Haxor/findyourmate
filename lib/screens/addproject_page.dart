// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourmate/screens/home_page.dart';
import 'package:findyourmate/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Addproject_page extends StatefulWidget {
  const Addproject_page({super.key});

  @override
  State<Addproject_page> createState() => _Addproject_pageState();
}

class _Addproject_pageState extends State<Addproject_page> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _skills = TextEditingController();
  final _members = TextEditingController();
  final _duration = TextEditingController();
  final _other = TextEditingController();

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("G-mate (Find your mate)"),
        centerTitle: true,
        backgroundColor:  const Color.fromARGB(255, 58, 130, 255),
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        
        width: MediaQuery.of(context).size.width,
        height : MediaQuery.of(context).size.height,
        color: const Color.fromARGB(255, 58, 130, 255),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                20, 20, 20, 0),
            child: Column(
            children: <Widget>[
                  
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Add Project details",
                    style: TextStyle(fontSize: 30, color: Color.fromARGB(178, 0, 0, 0),fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  reusableTextField("Enter Project Title", Icons.person_outline, false,
                      _title),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Project description", Icons.description_outlined, false,
                      _description),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Skills required", Icons.computer, false,
                      _skills),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter expected duration", Icons.timer_outlined, false,
                      _duration),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter No.of members requied", Icons.person, false,
                      _members),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Other deatils", Icons.calendar_month_outlined, false,
                      _other),
                  const SizedBox(
                    height: 20,
                  ),
                  firebaseUIButton(context, "Add project", () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(child: CircularProgressIndicator());
                    });
                    if ( _title.text.trim().isNotEmpty &&  _description.text.trim().isNotEmpty && _skills.text.trim().isNotEmpty && _duration.text.trim().isNotEmpty && _members.text.trim().isNotEmpty){
                      FirebaseFirestore.instance.collection("projects").add({
                      "title" : _title.text.trim(),
                      "description" : _description.text.trim(),
                      "skills" : _skills.text.trim(),
                      "email" : FirebaseAuth.instance.currentUser!.email,
                      "duration" : _duration.text.trim(),
                      "members" : _members.text.trim(),
                      "other"  : _other.text.trim(),
                      "time" : Timestamp.now(),
                      "likes" : [],
                      });
        
                      const snackBar = SnackBar(content: Text("Project Added successfully"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Homepage()));
                    }
                    else {
                      const snackBar = SnackBar(content: Text("Please Enter all Deatils"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pop();
                    }
                  },
                  ),
                  IconButton(onPressed: () {
                    Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Homepage()));
                    }, 
                    icon: const Icon(Icons.arrow_back_rounded), 
                    iconSize: 40,
                  )
                ]
        ),
        )
          ),
      ));
  }
}