import 'package:beevent_flutter/Model/Repository/DatabaseOperations.dart';
import 'package:beevent_flutter/Model/RequestDetailModels.dart';
import 'package:flutter/material.dart';
import 'package:beevent_flutter/View/DetailedRequestPage.dart';
import 'package:beevent_flutter/View/EditRequestPage.dart'; // Ekledim

import 'package:flutter/material.dart';
import 'package:beevent_flutter/Model/Repository/DatabaseOperations.dart';
import 'package:beevent_flutter/View/DetailedRequestPage.dart';
import 'package:beevent_flutter/View/EditRequestPage.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  List<BloodRequest> requestsList = []; // Güncellendi

  @override
  void initState() {
    super.initState();
    fetchBloodRequests(); // fetchBloodRequests fonksiyonunu çağır
  }

  Future<void> fetchBloodRequests() async {
    try {
      DatabaseOperation databaseOperation = DatabaseOperation();
      List<BloodRequest> bloodRequests = await databaseOperation.fetchBloodRequests();
      setState(() {
        requestsList = bloodRequests;
      });
    } catch (e) {
      print('Error fetching blood requests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Requests'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepOrangeAccent, Colors.orange],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_sharp),
            tooltip: 'Filter',
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange.shade50, Colors.orange.shade100],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: requestsList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailedRequestPage(requestsList[index]),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' ${requestsList[index].title}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Blood Type: ${requestsList[index].bloodType}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'City: ${requestsList[index].hospital.location.city}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Description: ${requestsList[index].description}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditRequestPage()));
        },
        tooltip: 'Edit Request',
        child: Icon(Icons.edit),
      ),
    );
  }
}

