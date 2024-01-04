import 'package:beevent_flutter/Model/Repository/DatabaseOperations.dart';
import 'package:flutter/material.dart';

class EditRequestPage extends StatefulWidget {
  final String? initialCity;
  final String? initialBloodType;
  final String? initialHospital;
  final String? initialTitle;
  final String? initialDescription;
  final int? requestId;




  EditRequestPage({
    Key? key,
    this.initialCity,
    this.initialBloodType,
    this.initialHospital,
    this.initialTitle,
    this.initialDescription,
    this.requestId,

  }) : super(key: key);

  @override
  _EditRequestPageState createState() => _EditRequestPageState();

}

class _EditRequestPageState extends State<EditRequestPage> {
  String? selectedCity;
  String? selectedBloodType;
  String? selectedHospital;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values based on passed data
    selectedCity = widget.initialCity;
    selectedBloodType = widget.initialBloodType;
    selectedHospital = widget.initialHospital;
    titleController.text = widget.initialTitle ?? '';
    descriptionController.text = widget.initialDescription ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Request'),
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
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                  padding: EdgeInsets.symmetric(horizontal: 70.0),
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
                  onPressed: _editRequest,
                  child: Text('Edit Request'),
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

  void _editRequest() {
    DatabaseOperation _databaseOperation = DatabaseOperation();
    _databaseOperation.editRequest(
      requestId: widget.requestId?? 0,
    );
  }
}
