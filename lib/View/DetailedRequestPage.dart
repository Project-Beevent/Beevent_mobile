import 'package:flutter/material.dart';

class DetailedRequestPage extends StatelessWidget {
  final RequestData requestData;

  DetailedRequestPage(this.requestData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(requestData.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Details:'),
            SizedBox(height: 8),
            Text(requestData.details),
          ],
        ),
      ),
    );
  }
}

class RequestData {
  final String title;
  final String details;

  RequestData(this.title, this.details);
}