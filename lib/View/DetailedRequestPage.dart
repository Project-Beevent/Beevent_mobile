import 'package:beevent_flutter/Model/RequestDetailModels.dart';
import 'package:flutter/material.dart';
import 'package:beevent_flutter/Model/Repository/DatabaseOperations.dart';

class DetailedRequestPage extends StatelessWidget {
  final BloodRequest bloodRequest;

  DetailedRequestPage(this.bloodRequest);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${bloodRequest.title}"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView( // SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem('Description', bloodRequest.description),
            _buildDetailItem('Status', bloodRequest.status),
            _buildDetailItem('Blood Type', bloodRequest.bloodType),
            _buildDetailItem('Request Date', _formatDate(bloodRequest.dateRequested)),
            _buildDetailItem('Hospital', bloodRequest.hospital.name),
            _buildDetailItem('City', bloodRequest.hospital.location.city),
            _buildDetailItem('District', bloodRequest.hospital.location.district),
            //_buildDetailItem('Mahalle', bloodRequest.hospital.location.mahalle),
            _buildDetailItem('Owner', bloodRequest.user.fullName),
            _buildDetailItem('Owner Email', bloodRequest.user.email),
            _buildDetailItem('Owner Phone', bloodRequest.user.phone),
            //_buildDetailItem('User Gender', bloodRequest.user.gender),
            //_buildDetailItem('User Blood Type', bloodRequest.user.bloodType),
            // _buildDetailItem('User Age', bloodRequest.user.age.toString()),
            //_buildDetailItem('User Last Donation Date', _formatDate(bloodRequest.user.lastDonationDate)),
            //_buildDetailItem('User Donation Count', bloodRequest.user.donationCount.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text(value),
        SizedBox(height: 16),
        Divider(height: 1, color: Colors.grey),
        SizedBox(height: 16),
      ],
    );
  }

  String _formatDate(List<int> dateList) {
    if (dateList.length == 3) {
      return '${dateList[2]}.${dateList[1]}.${dateList[0]}';
    } else {
      return 'Invalid Date';
    }
  }
}

