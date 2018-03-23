import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blue,
      floatingActionButton: new FloatingActionButton(
         child: new Icon(Icons.arrow_right),
         onPressed: () => print('Pressed'),
      ),
    );
  }
}