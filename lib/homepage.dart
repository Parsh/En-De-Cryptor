import 'package:flutter/material.dart';
import 'package:tripledes/tripledes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var key;
  var message;
  var cipher;
  var ciphertext = "";
  var decipher;
  var decipherText = "";
  var blockCipher;
  TextEditingController messageController;
  TextEditingController keyController;

  encoder() {
    setState(() {
      this.key = keyController.text;
      this.blockCipher = new BlockCipher(new DESEngine(), key);
      this.message = messageController.text;
      this.cipher = blockCipher.encodeB64(message);
      this.ciphertext = 'CipherText: "$cipher"';
    });
  }

  decoder() {
    setState(() {
      this.decipher = blockCipher.decodeB64(this.cipher);
      this.decipherText = 'DecipherText: "$decipher"';
    });
  }

  @override
  void initState() {
    super.initState();
    messageController = new TextEditingController();
    keyController = new TextEditingController();
  }

  @override
  void dispose() {
    messageController.dispose();
    keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("#En/De-Cryptor"),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body: new ListView(
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.only(top: 50.0),
              child: new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new TextField(
                        decoration: new InputDecoration(
                          hintText: 'Enter the message',
                          hintStyle: new TextStyle(fontSize: 21.0),
                        ),
                        controller: messageController,
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new TextField(
                        decoration: new InputDecoration(
                          hintText: 'Enter the key',
                          hintStyle: new TextStyle(fontSize: 21.0),
                        ),
                        controller: keyController,
                      ),
                    ),
                    new Padding(
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
                      child: new RaisedButton(
                        color: Colors.blue,
                        child: new Text(
                          "Encrypt",
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white),
                        ),
                        onPressed: encoder,
                      ),
                    ),
                    new Padding(
                      padding:
                          const EdgeInsets.all(10.0),
                      child: new Text(
                        ciphertext,
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 19.0),
                      ),
                    ),
                    new Opacity(
                      opacity: this.cipher == null ? 0.0 : 1.0,
                      child: new Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
                        child: new RaisedButton(
                          color: Colors.blue,
                          child: new Text(
                            "Decrypt",
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.white),
                          ),
                          onPressed: decoder,
                        ),
                      ),
                    ),
                    new Padding(
                      padding:
                          const EdgeInsets.all(10.0),
                      child: new Text(
                        decipherText,
                        textAlign: TextAlign.center,
                        style: new TextStyle(fontSize: 19.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
