import 'package:beevent_flutter/View/EditRequestPage.dart';
import 'package:flutter/material.dart';
import 'package:beevent_flutter/Model/Repository/DatabaseOperations.dart';

import '../Model/RequestDetailModels.dart';

class MyRequests extends StatefulWidget {
  final String userEmail;

  MyRequests({required this.userEmail});

  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  final DatabaseOperation _databaseOperation = DatabaseOperation();
  late List<BloodRequest> _userRequests;

  @override
  void initState() {
    super.initState();
    _userRequests = [];


    _loadUserRequests();
  }

  Future<void> _loadUserRequests() async {
    try {
      List<BloodRequest> requests =
      await _databaseOperation.getUserRequests(widget.userEmail);

      setState(() {
        _userRequests = requests;
      });
    } catch (e) {
      print('Error loading user requests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade200,
      appBar: AppBar(
        title: Text('My Requests'),
        backgroundColor: Colors.orange,
      ),
      body: _userRequests.isNotEmpty
          ? ListView.builder(
        itemCount: _userRequests.length,
        itemBuilder: (context, index) {
          BloodRequest request = _userRequests[index];
          return ListTile(
            title: Text(request.title),
            subtitle: Text(request.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditRequestPage(requestId: request.id)));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {

                    //_deleteRequest(request.id);
                  },
                ),
              ],
            ),
          );
        },
      )
          : Center(
        child: Text('No requests found.'),
      ),
    );
  }

}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyRequests(userEmail: 'example@example.com'),
    ),
  );
}
