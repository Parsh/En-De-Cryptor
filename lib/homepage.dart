import 'package:flutter/material.dart';
import 'package:tripledes/tripledes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var key;
  var message;

  String encoder(var key, var message){ 
  this.key = key;
  var blockCipher = new BlockCipher(new DESEngine(), key);
  this.message = message;
  var ciphertext = blockCipher.encodeB64(message);
  var decoded = blockCipher.decodeB64(ciphertext);

  print("key: $key");
  print("message: $message");
  print("ciphertext (base64): $ciphertext");
  print("decoded ciphertext: $decoded");
  return ciphertext;
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blue,
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(encoder("Hey there", "Let's rock and roll baby"), style: new TextStyle(color: Colors.white, fontSize: 20.0),),
            ],
          ),
        ),
      ),
    );
  }
}
