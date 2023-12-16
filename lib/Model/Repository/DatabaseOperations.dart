import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:beevent_flutter/Model/Person.dart';

class DatabaseOperation {
  Future<List<Person>> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3001/posts'));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<Person> personList = jsonList.map((json) => Person.fromJson(json)).toList();
        return personList;
      } else {

        return [];
      }
    } catch (e) {

      return [];
    }
  }

  Future<String?> getFirstPersonName() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3001/posts'));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          return Person.fromJson(jsonList[0]).name;
        }
      } else {

      }
    } catch (e) {
      print('Error fetching first person name: $e');
    }
    return null;
  }

  }







