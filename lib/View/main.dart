import 'package:flutter/material.dart';
import 'package:beevent_flutter/View/ProfilePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KanVer App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:
          <Widget>[
            //add margin here
            const Padding(
              padding: EdgeInsets.all(20.0),
            ),

            //add padding here
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Welcome to KanVer',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //add padding here
            const Padding(
              padding: EdgeInsets.all(20.0),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Mail',
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(40.0),
            ),
            ElevatedButton(
              onPressed: () {
                //give alert that you have pushed the button
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Login'),
                      content: const Text('You have logged in successfully'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Login'),
              //make button square
              style: ElevatedButton.styleFrom(
                //make button fixed size
                minimumSize: const Size(250, 50),
                primary: Colors.indigo,
                onPrimary: Colors.white,
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Sign Up'),
              //make button square
              style: ElevatedButton.styleFrom(
                //make button blue
                minimumSize: const Size(250, 50),
                primary: Colors.indigo,
                //make text white
                onPrimary: Colors.white,
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
            ),
            ElevatedButton(
              //onpressed go to profile page
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: const Text('Go Profile'),
              //make button square
              style: ElevatedButton.styleFrom(
                //make button blue
                minimumSize: const Size(50, 50),
                primary: Colors.indigo,
                //make text white
                onPrimary: Colors.white,
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


