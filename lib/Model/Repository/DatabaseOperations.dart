import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:beevent_flutter/Model/Person.dart';

class DatabaseOperation {
  Future<List<Person>> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://[::1]:3001/posts'));
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

  Future<String?> getFirstPersonName() async {
    try {
      final response = await http.get(Uri.parse('https://siktigiminprojesi-default-rtdb.europe-west1.firebasedatabase.app/.json'));
      if (response.statusCode == 200) {
        String jsonData = response.body;


        Map<String, dynamic> jsonDataMap = json.decode(jsonData);


        var firstPersonKey = jsonDataMap.keys.first;
        return jsonDataMap[firstPersonKey];
      } else {
        print('Error fetching first person name: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching first person name2: $e');
    }
    return null;
  }



}







