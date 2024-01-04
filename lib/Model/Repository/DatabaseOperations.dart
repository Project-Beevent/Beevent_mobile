  import 'dart:convert';
import 'dart:math';
  import 'package:http/http.dart' as http;
  import 'package:beevent_flutter/Model/Person.dart';

import '../RequestDetailModels.dart';

 class DatabaseOperation {
   final Random random = Random();

   Future<List<Person>> fetchData() async {
     try {
       final response = await http.get(
           Uri.parse('http://20.241.134.230/users'));
       if (response.statusCode == 200) {
         List<dynamic> jsonList = json.decode(response.body);
         List<Person> personList = jsonList.map((json) => Person.fromJson(json))
             .toList();
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
       final response = await http.get(
           Uri.parse('http://20.241.134.230/users'));

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

   Future<void> createRequest(String email, String title, String description,
       String bloodType, String city, String hospital) async {
     int userId = 0;
     int hospitalId = 0;


     if (hospital == 'Ankara') {
       hospitalId = 2;
     }
     else {
       hospitalId = 1;
     };
     try {
       final response2 = await http.get(
           Uri.parse('http://20.241.134.230/users'));
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
         Uri.parse(
             'http://20.241.134.230/blood_requests/users/$userId/hospitals/$hospitalId'),
         headers: <String, String>{
           'Content-Type': 'application/json; charset=UTF-8',
         },
         body: jsonEncode(<String, String>{
           'title': title,
           'description': description,
           'bloodType': bloodType,
           'status': "Pending...",
           'dateRequested': "2024-06-01",
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

   Future<bool> checkUser(String enteredEmail, String enteredPassword) async {
     try {
       final response = await http.get(
           Uri.parse('http://20.241.134.230/users'));
       if (response.statusCode == 200) {
         List<dynamic> jsonDataList = json.decode(response.body);

         if (jsonDataList.isNotEmpty) {
           for (var jsonData in jsonDataList) {
             if (jsonData['email'] == enteredEmail &&
                 jsonData['password'] == enteredPassword) {
               return true;
             }
           }
         } else {
           print('Error: Empty JSON list');
         }
       } else {
         print('Error fetching user data: ${response.statusCode}');
       }
     } catch (e) {
       print('Error checking user: $e');
     }


     return false;
   }

   Future<bool> signUp(String fullName, String email, String password,
       String phone, String gender, String bloodType, int age) async {
     // Define a string named tcNo and value is random
     String tcNo = random.nextInt(1000000000).toString();

     try {
       final response = await http.post(
         Uri.parse('http://20.241.134.230/users'),
         headers: <String, String>{
           'Content-Type': 'application/json; charset=UTF-8',
         },
         body: jsonEncode(<String, dynamic>{
           'fullName': fullName,
           'email': email,
           'password': password,
           'phone': phone,
           'gender': gender,
           'bloodType': bloodType,
           'age': age,
           'tcNo': tcNo,
           'lastDonationDate': "2024-06-01",
         }),
       );

       if (response.statusCode == 201) {
         print('User registered successfully');
         return true;
       } else {
         print('Error registering user: ${response.statusCode}');
         print(response.body);
         return false;
       }
     } catch (e) {
       print('Error registering user: $e');
       return false; // Hata durumunda false döndür
     }
   }

   Future<List<BloodRequest>> getUserRequests(String userEmail) async {
     int userId = 0;

     try {
       final response2 = await http.get(
           Uri.parse('http://20.241.134.230/users'));

       for (var jsonData in json.decode(response2.body)) {
         if (jsonData['email'] == userEmail) {
           userId = jsonData['id'].toInt();
         }
       }

       final response = await http.get(
         Uri.parse('http://20.241.134.230/blood_requests/users/$userId'),
       );

       if (response.statusCode == 200) {
         List<dynamic> jsonResponse = json.decode(response.body);
         return jsonResponse.map((data) => BloodRequest.fromJson(data))
             .toList();
       } else {
         throw Exception('Failed to load user requests');
       }
     } catch (e) {
       print('Error fetching user requests: $e');
       throw e;
     }
   }

   void editRequest(
       {required int requestId, String? newTitle, String? newDescription, String? newBloodType, String? newCity, String? newHospital}) async {
     try {
       int hospitalId = 0;
       if (newHospital == 'Ankara') {
         hospitalId = 2;
       }
       else {
         hospitalId = 1;
       };

       final response = await http.put(
         Uri.parse('http://20.241.134.230/blood_requests/$requestId'),
         headers: <String, String>{
           'Content-Type': 'application/json; charset=UTF-8',
         },
         body: jsonEncode(<String, dynamic>{
           'title': newTitle ?? 'Updated Title',
           'description': newDescription ?? 'Updated Description',
           'bloodType': newBloodType ?? 'Updated Blood Type',
           'city': newCity ?? 'Updated City',
           'hospital': newHospital ?? 'Updated Hospital',
         }),
       );

       if (response.statusCode == 200) {
         print('Request updated successfully');
       } else {
         print('Error updating request: ${response.statusCode}');
         print(response.body);
       }
     } catch (e) {
       print('Error updating request: $e');
     }
   }
 }
