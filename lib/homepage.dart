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
  bool messageFlag = false;
  bool keyFlag = false;
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

    Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("Encrypted!"),
          duration: new Duration(seconds: 1),
        ));
  }

  decoder() {
    setState(() {
      this.decipher = blockCipher.decodeB64(this.cipher);
      this.decipherText = 'DecipherText: "$decipher"';
    });

    Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("Decrypted!"),
          duration: new Duration(seconds: 1),
        ));
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
    return new ListView(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.only(top: 35.0),
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
                  onChanged: (String str) {
                        this.cipher = null;
                        this.decipher = null;
                        this.ciphertext = "";
                        this.decipherText = "";
                    setState(() {
                      if (str.trim() == "") {
                        this.messageFlag = false;
                        Scaffold.of(context).showSnackBar(new SnackBar(
                              content: new Text("Require: Message to En/De-Crypt!"),
                              duration: new Duration(milliseconds: 800),
                            ));
                      } else {
                        this.messageFlag = true;
                      }
                    });
                  },
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
                  onChanged: (String str) {
                        
                        this.cipher = null;
                        this.decipher = null;
                        this.ciphertext = "";
                        this.decipherText = "";

                    setState(() {
                      if (str.trim() == "") {
                        this.keyFlag = false;
                        Scaffold.of(context).showSnackBar(new SnackBar(
                              content: new Text("Require: Key to En/De-Crypt!"),
                              duration: new Duration(milliseconds: 800),
                            ));
                      } else {
                        this.keyFlag = true;
                      }
                    });
                  },
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 30.0),
                child: new RaisedButton(
                  color: Colors.blue,
                  child: new Text(
                    "Encrypt",
                    style: new TextStyle(fontSize: 21.0, color: Colors.white),
                  ),
                  onPressed: this.messageFlag && this.keyFlag ? encoder : null,
                ),
              ),
              new Opacity(
                opacity: this.messageFlag && this.keyFlag && this.cipher != null
                    ? 1.0
                    : 0.0,
                child: new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(
                    ciphertext,
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontSize: 19.0),
                  ),
                ),
              ),
              new Opacity(
                opacity: this.messageFlag && this.keyFlag && this.cipher != null
                    ? 1.0
                    : 0.0,
                child: new Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
                  child: new RaisedButton(
                    color: Colors.blue,
                    child: new Text(
                      "Decrypt",
                      style: new TextStyle(fontSize: 21.0, color: Colors.white),
                    ),
                    onPressed: decoder,
                  ),
                ),
              ),
              new Opacity(
                opacity: this.messageFlag && this.keyFlag && this.cipher != null
                    ? 1.0
                    : 0.0,
                child: new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(
                    decipherText,
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontSize: 19.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
