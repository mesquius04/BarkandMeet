import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewDogScreen extends StatefulWidget {
  @override
  _NewDogScreenState createState() => _NewDogScreenState();
}

class _NewDogScreenState extends State<NewDogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear perfil de gos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nom del gos',
              ),
            ),
          ],
        ),
      ),
    );
  }
}