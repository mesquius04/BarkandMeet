import 'package:bark_and_meet/user_profile.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import "user.dart";

class ProfileCreatedScreen extends StatelessWidget {
  final User user;

  ProfileCreatedScreen({
    required this.user
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil Creado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Tu perfil ha sido creado con éxito!',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(
                      user: user
                    ),
                  ),
                );
              },
              child: Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
