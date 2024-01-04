import 'package:beevent_flutter/Model/Repository/DatabaseOperations.dart';
import 'package:flutter/material.dart';

class AddRequestPage extends StatefulWidget {
  final String userEmail;

  AddRequestPage({required this.userEmail});
  @override
  _AddRequestPageState createState() => _AddRequestPageState();
}

class _AddRequestPageState extends State<AddRequestPage> {
  String? selectedCity;
  String? selectedBloodType;
  String? selectedHospital;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DatabaseOperation databaseOperation = DatabaseOperation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Request'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange.shade100, Colors.deepOrange.shade100],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Request Information',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 128.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: DropdownButton<String>(
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    items: <String>[
                      'A+',
                      'A-',
                      'AB+',
                      'AB-',
                      'B+',
                      'B-',
                      'O+',
                      'O-'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedBloodType = newValue;
                      });
                    },
                    value: selectedBloodType,
                    hint: Text('Blood Type'),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Hospital and Location',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 132.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: DropdownButton<String>(
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    items: <String>[
                      'Ankara',
                      'İstanbul',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCity = newValue;
                      });
                    },
                    value: selectedCity,
                    hint: Text('City'),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 90.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: DropdownButton<String>(
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    items: <String>[
                      'Medilif',
                      'MediHaus',
                      'Medicane',
                      'Fatih Hospital',
                      'A Hastane',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedHospital = newValue;
                      });
                    },
                    value: selectedHospital,
                    hint: Text('Hospital'),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // fields cannot be empty
                    if (titleController.text.isEmpty ||
                        descriptionController.text.isEmpty ||
                        selectedBloodType == null ||
                        selectedCity == null ||
                        selectedHospital == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill all fields'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    databaseOperation.createRequest(
                      widget.userEmail,
                      titleController.text,
                      descriptionController.text,
                      selectedBloodType!,
                      selectedCity!,
                      selectedHospital!,
                    );
                    _clearFields();
                  },
                  child: Text('Create Request'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(380, 50),
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _clearFields,
                  child: Text('Clear'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(380, 50),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _clearFields() {
    // Clear button pressed, clear all fields
    setState(() {
      selectedCity = null;
      selectedBloodType = null;
      selectedHospital = null;
      titleController.clear();
      descriptionController.clear();
    });
  }
}

void main() {
  runApp(
    MaterialApp(
      home: AddRequestPage(userEmail: 'example@email.com'),
    ),
  );
}