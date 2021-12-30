// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'hard.dart';
import 'simple.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  static const appTitle = 'Password Generator';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var list = ["A67B^cd*"];

  bool valid = false;
  final ref = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: valid
          ? ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                return ListTile(title: Text(list[index]));
              })
          : Text("retrieve data first"),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text(
                'Password Genarator',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'SIMPLE',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => simple()));
              },
            ),
            ListTile(
              title: const Text(
                'HARD',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => hard()));
              },
            ),
            ListTile(
              title: const Text(
                'Upload Password',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                ),
              ),
              onTap: () async {
                // Update the state of the app
                // ...
                for (var item in list) {
                  await ref.child("passwords").push().set(item);
                }
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'Reterive Password',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                ),
              ),
              onTap: () async {
                // Update the state of the app
                // ...
                DataSnapshot ds = await ref
                    .child("passwords")
                    .once()
                    .then((value) => value.snapshot);
                if (ds.exists && ds.value != null) {
                  Map mp = ds.value as Map;
                  mp.forEach((key, value) {
                    list.add(value.toString());
                  });
                }
                setState(() {
                  valid = true;
                });
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
