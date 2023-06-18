// ignore_for_file: camel_case_types, prefer_const_constructors, unused_local_variable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:findyourmate/screens/addproject_page.dart';
import 'package:findyourmate/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Projects_page extends StatelessWidget {
  const Projects_page({super.key});

  Future<List<Map<String, dynamic>>> fetchData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    
    if (currentUser == null) {
      return []; // Return an empty list if the user is not logged in
    }

    final email = currentUser.email;
    
    final snapshot = await FirebaseFirestore.instance
        .collection('projects')
        .where('email', isEqualTo: email)
        .get();

    final dataList = snapshot.docs.map((doc) => doc.data()).toList();
    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final dataList = snapshot.data;
          
          if (dataList == null || dataList.isEmpty) {
            return Center(
              child: ElevatedButton(
                child: const Text('Add projects'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Addproject_page()),
                  );
                },
              ),
            );
          }

          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,50,8,8),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors:  [
                              hexStringToColor("93acf8"),
                              hexStringToColor("2e68ff"),
                            ] , begin: Alignment.topLeft , end: Alignment.bottomRight
                          ),
                        borderRadius: BorderRadius.circular(10),
                        
                      ),
                       child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          
                          children: [
                            Text('  Project id :${itemIndex+1}', style: TextStyle(fontWeight: FontWeight.bold),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${dataList[itemIndex]["title"]}', style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Description      :  ${dataList[itemIndex]["description"]}', style: TextStyle(fontSize: 16.0),),
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Skills required  : ${dataList[itemIndex]["skills"]}', style: TextStyle(fontSize: 16.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Members required : ${dataList[itemIndex]["members"]}', style: TextStyle(fontSize: 16.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Expected time required : ${dataList[itemIndex]["duration"]}', style: TextStyle(fontSize: 16.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Other deatils : ${dataList[itemIndex]["other"]}', style: TextStyle(fontSize: 16.0),),
                            ),
                          ]
                        ),
                      ),
                      

                    ),
                  ), options: CarouselOptions(
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    aspectRatio: 0.65,
                    initialPage: 0,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
              ),
            TextButton.icon(
              onPressed: () { Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Addproject_page())); }, 
              icon: const Icon(
                  
                  Icons.post_add_outlined,
                  color: Color.fromARGB(255, 2, 2, 2),
                  size: 30.0,
                ), 
              label: Text("Add new project"),
              ),
            ],
          );
          
        }
      ),
    );
  }

  void onPressed() {
  }
}

