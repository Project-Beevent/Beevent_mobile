  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:beevent_flutter/Model/Person.dart';

  class DatabaseOperation {
    Future<List<Person>> fetchData() async {
      try {
        final response = await http.get(Uri.parse('http://20.241.134.230/users'));
        if (response.statusCode == 200) {
          List<dynamic> jsonList = json.decode(response.body);
          List<Person> personList = jsonList.map((json) => Person.fromJson(json)).toList();
          print(personList);
          print("personList");
          return personList;
        } else {
          print('Error fetching data: ${response.statusCode}');
          return [];
        }
      } catch (e) {
        print('Error fetching data: $e');
        return [];
      }
    }

    Future<String?> getPersonData(String email) async {
      try {
        final response = await http.get(Uri.parse('http://20.241.134.230/users'));

        if (response.statusCode == 200) {
          List<dynamic> jsonDataList = json.decode(response.body);

          if (jsonDataList.isNotEmpty) {
            for (var jsonData in jsonDataList) {
              if (jsonData['email'] == email) {

                String personData = '''
              Name: ${jsonData['fullName']}
              Email: ${jsonData['email']}
              Phone: ${jsonData['phone']}
              Gender: ${jsonData['gender']}
              Blood Type: ${jsonData['bloodType']}
              Age: ${jsonData['age']}
              Last Donation Date: ${jsonData['lastDonationDate']}
              Donation Count: ${jsonData['donationCount']}
            ''';
                return personData;
              }
            }
          } else {
            print('Error: Empty JSON list');
          }
        } else {
          print('Error fetching person data: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching person data: $e');
      }

      return null;
    }

    Future<void> createRequest(String email, String title, String description, String bloodType, String city, String hospital) async {
      int userId = 0;
      int hospitalId = 0;
      if(hospital == 'Ankara'){
        hospitalId = 2;
      }
      else{
        hospitalId = 1;
      };
      try {
        final response2 = await http.get(Uri.parse('http://20.241.134.230/users'));
        if (response2.statusCode == 200) {
          List<dynamic> jsonDataList = json.decode(response2.body);
          if (jsonDataList.isNotEmpty) {
            for (var jsonData in jsonDataList) {
              if (jsonData['email'] == email) {
                userId = jsonData['id'].toInt();
              }
            }
          } else {
            print('Error: Empty JSON list');
          }
        } else {
          print('Error fetching person data: ${response2.statusCode}');
        }

        final response = await http.post(
          Uri.parse('http://20.241.134.230/blood_requests/users/$userId/hospitals/$hospitalId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'title': title,
            'description': description,
            'bloodType': bloodType,
            'status' : "Pending...",
            'dateRequested' : "2024-06-01",
          }),
        );
        print(userId);
        print(hospitalId);
        if (response.statusCode == 201) {
          print('Request created successfully');
        } else {
          print('Error creating request: ${response.statusCode}');
          print(response.body);
        }
      } catch (e) {
        print('Error creating request: $e');
      }
    }






  }







