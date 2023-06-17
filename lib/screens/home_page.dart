import 'package:findyourmate/screens/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: ElevatedButton(
          child: Text("singed as " + user.email! + "  , press to Logout"),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              const snackBar = SnackBar(content: Text("Your are logged out"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignIn_page()));
            });
          },
        ),
      ),
    );
  }
}