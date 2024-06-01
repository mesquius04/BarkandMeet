import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class RecuperarContrasenyaScreen extends StatefulWidget {
  @override
  _RecuperarContrasenyaState createState() => _RecuperarContrasenyaState();
}

class _RecuperarContrasenyaState extends State<RecuperarContrasenyaScreen> {
  final _emailController = TextEditingController();
  String? _errorMessage; // Missatge d'error

  Future<void> _recuperarContrasenya(BuildContext context) async {
    // Es restableix el missatge d'error.
    setState(() {
      _errorMessage = null;
    });

    // es crida a la funció de firebase per verificar el correu i contrasenya per iniciar sessió
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      // es mostra un popup per informar que s'ha enviat un correu per restablir la contrasenya
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Correu enviat'),
          content: Text(
              'S\'ha enviat un correu electrònic per restablir la contrasenya.'),
          actions: [
            TextButton(
              onPressed: () {
                // Es va al la vista del perfil de l'usuari
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text('D\'acord'),
            )
          ],
        ),
      );



    } on FirebaseAuthException catch (error) {
      // Controlar errors.

      // Si hi ha un error, s'assigna un valor a _errorMessage perquè surti a la pantalla
      setState(() {
        switch (error.code) {
          case "invalid-email":
            _errorMessage = "El format del correu electrònic és erroni.";
            break;
          case "user-not-found":
            _errorMessage =
                "No existeix cap compte amb aquest correu electrònic.";
            break;
          case "too-many-requests":
            _errorMessage =
                "S'ha fet massa peticions. Torna-ho a intentar més tard.";
            break;
        }
      });

      // S'imprimeix l'error a la consola
      print("Error a l'iniciar sessió: $error");
    }
  }

  // es crida aquest mètode per alliberar recursos de memòria quan no s'utilitzen.
  // en aquest cas es llibera la memòria dels controladors del correu i contrasenya
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar contrasenya'),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'Per recuperar la contrasenya, entra el teu correu electrònic:'),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correu electrònic',
                border: OutlineInputBorder(),
              ),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _recuperarContrasenya(context),
              child: Text('Recuperar contrasenya'),
            )
          ],
        ),
      )),
    );
  }
}
