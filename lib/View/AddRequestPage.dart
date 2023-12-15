import 'package:flutter/material.dart';

class AddRequestPage extends StatefulWidget {
  const AddRequestPage({Key? key}) : super(key: key);

  @override
  _AddRequestPageState createState() => _AddRequestPageState();
}

class _AddRequestPageState extends State<AddRequestPage> {
  String? selectedCity;
  String? selectedBloodType;
  String? selectedHospital;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Request'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
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
                padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                maxLines: 5, // Maksimum satır sayısı
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
                padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                    'İzmir',
                    'Adana',
                    'Adıyaman',
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
                padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                    'Florence Nightingale',
                    'Acıbadem',
                    'Memorial',
                    'Medicana',
                    'Anadolu',
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
                onPressed: () {},
                child: Text('Create Request'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(380, 50),
                  primary: Colors.indigo,
                  onPrimary: Colors.white,
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
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
            ],
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
    const MaterialApp(
      home: AddRequestPage(),
    ),
  );
}
