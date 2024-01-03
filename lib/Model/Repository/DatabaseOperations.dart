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

    Future<Person?> getPerson(String email) async {
      try {
        final response = await http.get(Uri.parse('http://20.241.134.230/users'));

        if (response.statusCode == 200) {
          List<dynamic> jsonDataList = json.decode(response.body);

          if (jsonDataList.isNotEmpty) {
            for (var jsonData in jsonDataList) {
              if (jsonData['email'] == email) {
                return Person.fromJson(jsonData);
              }
            }
          } else {
            print('Error: Empty JSON list');
          }
        } else {
          print('Error fetching person: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching person: $e');
      }
      return null;
    }





  }







