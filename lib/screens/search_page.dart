// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class search_page extends StatefulWidget {
  const search_page({super.key});

  @override
  State<search_page> createState() => _search_pageState();
}

class _search_pageState extends State<search_page> {
  List searchresult = [];
  @override
  void initState() {
    super.initState();
    serachFromFirebase('.');
  }

  void serachFromFirebase(String query) async {
    // ignore: await_only_futures
    final result = await FirebaseFirestore.instance.collection("users").where('skills', isGreaterThanOrEqualTo: query).get();
    
    setState(() {
      searchresult = result.docs.map((e) => e.data()).toList();
    });
    
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           Padding(
            padding: EdgeInsets.all(15.0),
            child : TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search Here by skills"
              ),
              onChanged: (query){
                serachFromFirebase(query);
                
              },
            )
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchresult.length,
              itemBuilder: (context, index){
                return ListTile(
                   title: Text(searchresult[index]["skills"]),
                   subtitle: Text(searchresult[index]["email"]),
                );
              },
              ),
            ),
        ],
      )
    );
  }
}