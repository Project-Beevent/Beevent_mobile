  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:beevent_flutter/Model/Person.dart';

import '../RequestDetailModels.dart';

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
                // Person nesnesinden gelen verileri birleştirilmiş bir string olarak oluştur
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


    Future<List<BloodRequest>> fetchBloodRequests() async {
      final uri = Uri.parse('http://20.241.134.230/blood_requests');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => BloodRequest.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load blood requests');
      }
    }

  }







