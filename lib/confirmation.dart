import 'package:bark_and_meet/user_profile.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import "user_data.dart";

class ProfileCreatedScreen extends StatelessWidget {
  final File? profilePhoto;
  final String name;
  final String surname;
  final String email;
  final String location;
  final String additionalInfo;

  ProfileCreatedScreen({
    required this.profilePhoto,
    required this.name,
    required this.surname,
    required this.email,
    required this.location,
    required this.additionalInfo,
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
                UserData userData = UserData();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(
                      profilePhoto: UserData().profilePhoto,
                      name: UserData().name,
                      surname: UserData().surname,
                      email: UserData().email,
                      location: UserData().location,
                      additionalInfo: UserData().additionalInfo,
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
