// ignore_for_file: camel_case_types, prefer_const_constructors, unused_local_variable

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
                    MaterialPageRoute(builder: (context) => AddProjects()),
                  );
                },
              ),
            );
          }

          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              final data = dataList[index];
              // final dataId = snapshot.data?[index];
              
              return Card(
                child: ListTile(
                  title: Text(data['title'].toString()),
                  subtitle: Text(data['description'].toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Perform edit operation for the data with ID dataId
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AddProjects extends StatelessWidget {
  const AddProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: Center(
        child: Text('No data available.'),
      ),
    );
  }
}
