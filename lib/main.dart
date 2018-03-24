import 'package:flutter/material.dart';

import 'homepage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "D/En-Cryptor",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("#En/De-Cryptor"),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: new HomePage()
    )
  );
  }
}
