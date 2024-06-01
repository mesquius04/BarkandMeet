import 'package:bark_and_meet/Mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'user_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage; // Missatge d'error

  UserProfile getUser(String mail, String password){
    UserProfile user;
    // XAVIII RECUPEREM USER
    user= UserProfile(city: 'Barcelona', username: 'oliviar' , email: mail, name: 'Olivia' , surname: 'Rodrigo', gossera: false, numDogs: 0, premium: false, additionalInfo: '');
    return user;
  }

  Future<void> _login(BuildContext context) async {

    // Es restableix el missatge d'error.
    setState(() {
      _errorMessage = null;
    });

    UserProfile userProfile = UserProfile(
        username: "Olivia",
        email: "no@no",
        name: "Olivia",
        surname: "Rodrigo",
        numDogs: 0,
        gossera: false,
        premium: true,
        city: "Llafranc",
        additionalInfo: "I'm so american");
    // es crida a la funció de firebase per verificar el correu i contrasenya per iniciar sessió
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Es va al la vista del perfil de l'usuari
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => UserProfileScreen(user: userProfile,)),
          (route) => false,
      );
    } on FirebaseAuthException catch (error) {
      // Controlar errors.

      // Si hi ha un error, s'assigna un valor a _errorMessage perquè surti a la pantalla
      setState(() {
        if (error.code == "invalid-email") {
          _errorMessage = "El format del correu electrònic és erroni.";
        } else {
          _errorMessage = "Usuari o contrasenya incorrectes";
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
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Iniciar Sesión',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),

              // Text Field de Correu
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correu electrònic',
                  border: OutlineInputBorder()
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce tu correo electrónico';
                  }
                  return null;
                },

              ),

              // Text Field de contrasenya
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Contrasenya',
                    border: OutlineInputBorder()
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce tu contraseña';
                  }
                  return null;
                },
              ),

              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),

              // Botó de Iniciar Sessió
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _login(context),
                  child: Text('Iniciar Sesión'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
