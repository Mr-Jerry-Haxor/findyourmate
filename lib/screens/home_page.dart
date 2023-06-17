// ignore_for_file: prefer_final_fields

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:findyourmate/screens/chat_page.dart';
import 'package:findyourmate/screens/profile.dart';
import 'package:findyourmate/screens/projects_page.dart';
import 'package:findyourmate/screens/search_page.dart';
import 'package:findyourmate/screens/wallofprojects_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser!;
  // State class
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

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
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          animationDuration : const Duration(microseconds: 300),
          color : const Color.fromARGB(255, 58, 130, 255),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          items: const [
            CurvedNavigationBarItem(
              child: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.search),
              label: 'Search',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.chat_bubble_outline),
              label: 'Chat',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.newspaper),
              label: 'Projects',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.perm_identity),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: Container(
          color:  const Color.fromARGB(255, 255, 255, 255),
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: getSelectedWidget(index: _page),
        )
    );
  }
  Widget getSelectedWidget({required int index}){
    Widget widget;
    switch(index){
      case 0:
        widget = const wallofprojects_page();
        break;
      case 1:
        widget = const search_page();
        break;
      case 2:
        widget = const chat_page();
        break;
      case 3:
        widget = const Projects_page();
        break;
      case 4:
        widget = profilepage();
        break;
      default :
        widget=const wallofprojects_page();
        break;

    }
    return widget;
  }
}