import 'package:flutter/material.dart';
import 'package:beevent_flutter/View/DetailedRequestPage.dart';
import 'package:beevent_flutter/View/EditRequestPage.dart';

class Requests extends StatelessWidget {
  List<RequestData> requestsList = [
    RequestData('Request 1  AB+', 'Details for Request 1'),
    RequestData('Request 2   A-', 'Details for Request 2'),
    RequestData('Request 3   0+', 'Details for Request 3'),
    RequestData('Request 4   A+', 'Details for Request 4'),
    RequestData('Request 5   B+', 'Details for Request 5'),
  ];

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
                  child: ExpansionTile(
                    title: Text(requestsList[index].title),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(requestsList[index].details),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditRequestPage())); // Değişiklik burada HABERIN OLSUN
        },
        tooltip: 'Edit Request',
        child: Icon(Icons.edit),
      ),
    );
  }
}
