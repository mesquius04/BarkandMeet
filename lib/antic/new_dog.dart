import 'package:flutter/material.dart';

class NewDogScreen extends StatefulWidget {
  const NewDogScreen({super.key});

  @override
  _NewDogScreenState createState() => _NewDogScreenState();
}

class _NewDogScreenState extends State<NewDogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear perfil de gos'),
      ),
      body: const Center(
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