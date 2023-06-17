// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourmate/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profilepage extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    Future<void> editFiled(String field) async {
    String newValue = "";
    await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit your $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.grey)
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            child: Text(
              "Cancel",
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              "Save",
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          )
        ],
      )
      );
      if (newValue.trim().isNotEmpty){
        await usersCollection.doc(currentUser.email).update({field : newValue});
      }
  }
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(currentUser.email).get(),
      builder: ((context , snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =  snapshot.data!.data() as Map<String, dynamic>;
          return ListView(
              children: [
                const SizedBox(height: 10),
                const Icon(
                  Icons.person,
                  size: 72,
                ),
                const SizedBox(height: 10),
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color.fromARGB(255, 155, 155, 155))
                ),

                //user details 
                subheading("First Name"),
                profile_text_box(
                  field_text: data['firstname'],
                  onPressed: () => editFiled('firstname'), ),
                subheading("Last Name"),
                profile_text_box(
                  field_text: data['lastname'],
                  onPressed: () => editFiled('lastname'), ),
                subheading("Mobile no"),
                profile_text_box(
                  field_text: data['phoneno'],
                  onPressed: () => editFiled('phoneno'), ),
                subheading("Address Name"),
                profile_text_box(
                  field_text: data['address'],
                  onPressed: () => editFiled('address'), ),
                subheading("Stydent / Job"),
                profile_text_box(
                  field_text: data['work'],
                  onPressed: () => editFiled('work'), ),
                subheading("Skills"),
                profile_text_box(
                  field_text: data['skills'],
                  onPressed: () => editFiled('skills'), ),
                  subheading("Education"),
                profile_text_box(
                  field_text: data['study'],
                  onPressed: () => editFiled('study'), ),
                subheading("Projects"),
                profile_text_box(
                  field_text: data['projects'],
                  onPressed: () => editFiled('projects'), ),
                subheading("Experence(if any)"),
                profile_text_box(
                  field_text: data['experience'],
                  onPressed: () => editFiled('experience'), ),
                const SizedBox(height: 70)
              ]
            );
        }
        return CircularProgressIndicator();
      }
      ),
    );
  }
  Padding subheading (String text){
    return Padding(
      padding: const EdgeInsets.only(left:25.0,top:25.0),
      child: Text(
        text,
        style: TextStyle(color: Color.fromARGB(255, 155, 155, 155))
      ),
    );
  }
}