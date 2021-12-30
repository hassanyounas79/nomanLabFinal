import 'package:flutter/material.dart';

import 'main.dart';


class simple extends StatelessWidget {
  const simple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Simple';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body:  MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatelessWidget {
   MyCustomForm({Key? key}) : super(key: key);
  String spass="A67B^cd*";

  @override
  Widget build(BuildContext context) {
    return Center(
     child:Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Text("Simple password is: $spass"),
         Padding( padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
             child: ElevatedButton(onPressed: (){

               Navigator.push(context, MaterialPageRoute(builder: (c)=>MyApp()));

             }, child: Text("go back"))),
       ],
     ),

    );
  }
}