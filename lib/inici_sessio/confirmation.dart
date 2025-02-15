import 'package:bark_and_meet/vista_inici.dart';
import 'package:flutter/material.dart';
import "../model/user.dart";

class ProfileCreatedScreen extends StatelessWidget {
  final UserProfile user;

  const ProfileCreatedScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil Creado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "El teu perfil s'ha creat correctament!",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VistaInici(user: user, index: 3)),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(16), // Redondear la parte de abajo
                    top:
                        Radius.circular(0), // Mantener la parte de arriba recta
                  ),
                ),
              ),
              child: const Text(
                'Continuar',
                style: TextStyle(fontSize: 18), // Texto grande
              ),
            ),
          ],
        ),
      ),
    );
  }
}
