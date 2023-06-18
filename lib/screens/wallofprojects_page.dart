// ignore_for_file: camel_case_types

import 'package:carousel_slider/carousel_slider.dart';
import 'package:findyourmate/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WallofProjects_page extends StatelessWidget {
  const WallofProjects_page({super.key});

  Future<List<Map<String, dynamic>>> fetchData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('projects')
        .orderBy('time', descending: true)
        .get();

    final dataList = snapshot.docs.map((doc) => doc.data()).toList();

    return dataList;
  }

  String converttime(Timestamp t){
    DateTime dt=t.toDate();
    return dt.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Data List'),
      // ),
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
                child: const Text('Navigate to Another Page'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AnotherPage()),
                  );
                },
              ),
            );
          }

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(8,8,8,0),
                child: Text(
                  'Wall of projects',
                   style: TextStyle(fontWeight: FontWeight.bold , fontSize: 40)
                ),
              ),
              CarouselSlider.builder(
                
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,5,8,18),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,8,8,0),
                              child: Text('  Posted by : ${dataList[itemIndex]["email"]} ', style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,8,8,0),
                              child: Text('  on : ${converttime(dataList[itemIndex]["time"])} ', style: const TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${dataList[itemIndex]["title"]}', style: const TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Description      :  ${dataList[itemIndex]["description"]}', style: const TextStyle(fontSize: 16.0),),
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Skills required  : ${dataList[itemIndex]["skills"]}', style: const TextStyle(fontSize: 16.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Members required : ${dataList[itemIndex]["members"]}', style: const TextStyle(fontSize: 16.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Expected time required : ${dataList[itemIndex]["duration"]}', style: const TextStyle(fontSize: 16.0),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Other deatils : ${dataList[itemIndex]["other"]}', style: const TextStyle(fontSize: 16.0),),
                            ),
                          ]
                        ),
                      ),
                      

                    ),
                  ), options: CarouselOptions(
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    aspectRatio: 0.65,
                    initialPage: 0,
                    scrollDirection: Axis.vertical,
                    autoPlay: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 500),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: false,
                  ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Page'),
      ),
      body: const Center(
        child: Text('No data available.'),
      ),
    );
  }
}