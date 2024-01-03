import 'package:flutter/material.dart';
import 'package:beevent_flutter/View/Requests.dart';
import 'package:beevent_flutter/View/AddRequestPage.dart';
import 'package:beevent_flutter/Model/Person.dart';
import '../Model/Repository/DatabaseOperations.dart';

class ProfilePage extends StatefulWidget {
  final String userEmail;

  ProfilePage({required this.userEmail});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DatabaseOperation databaseOperation = DatabaseOperation();
  Person? person;
  late Future<List<Person>> personList;

  @override
  void initState() {
    super.initState();
    personList = databaseOperation.fetchData();
    databaseOperation.getPerson(widget.userEmail).then((retrievedPerson) {
      setState(() {
        person = retrievedPerson;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade200,
      appBar: AppBar(
        title: const Text('Profile'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrangeAccent, Colors.orangeAccent, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'Notifications',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Share',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder<String?>(
                future: databaseOperation.getPerson(widget.userEmail).then((retrievedPerson) {
                  return retrievedPerson?.name.toString();
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text(
                      snapshot.data ?? '',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 5,
                color: Colors.limeAccent,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'General Information',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 2,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      FutureBuilder<List<Person>>(
                        future: personList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            List<Person> people = snapshot.data!;
                            Person person = people[0];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name: ${person.name}'),
                                Text('Email: ${person.email}'),
                                Text('Phone: ${person.phone}'),
                                Text('Gender: ${person.gender}'),
                                Text('Blood Type: ${person.bloodType}'),
                                Text('Age: ${person.age}'),
                                Text('Last Donation Date: ${person.lastDonationDate}'),
                                Text('Donation Count: ${person.donationCount}'),
                                // Diğer genel bilgileri buraya ekleyebilirsiniz
                              ],
                            );
                          } else {
                            return Text('No data available');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // ... Diğer kodlar ...
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddRequestPage()));
        },
        tooltip: 'Add Request',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart_outlined),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ad_units_outlined),
            label: 'My Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Requests()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(userEmail: widget.userEmail)),
            );
          }
        },
      ),
    );
  }
}
