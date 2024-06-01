import 'dog.dart';
import 'package:flutter/material.dart';
import 'Mainpage.dart';

class ProfileScreen extends StatelessWidget {
  Dog currentdog;
  ProfileScreen({required this.currentdog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentdog.name),
      ),
      body: Center(
        child: Text('Perfil de' + currentdog.name),
      ),
    );
  }
}