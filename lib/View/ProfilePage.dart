// profile_page.dart

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.indigo,
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
              Text(
                'Name',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'General Information',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text('Email: user@example.com', style: TextStyle(fontSize: 20)),
                      Text('Phone: 553 335 0444', style: TextStyle(fontSize: 20)),
                      Text('Gender: Male', style: TextStyle(fontSize: 20)),
                      Text('Tc No: 12345678910', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Donations',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text('Status: You can donate!', style: TextStyle(fontSize: 20)),
                      Text('Last Donations: 26 03 2023', style: TextStyle(fontSize: 18)),
                      TextButton(
                        onPressed: () {
                          // Show a popup instead of navigating to a new screen
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Previous Donations'),
                                content: const Text('List of Previous Donations'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          'See your previous donations',
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
