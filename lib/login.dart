import 'package:bark_and_meet/Mainpage.dart';
import 'package:bark_and_meet/recuperar_contrasenya.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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


  Future<void> _login(BuildContext context) async {

    // Es restableix el missatge d'error.
    setState(() {
      _errorMessage = null;
    });

    // es crida a la funció de firebase per verificar el correu i contrasenya per iniciar sessió
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // agafar la info del user de firestore
      User? firebaseUser = FirebaseAuth.instance.currentUser;

      final userCollection = FirebaseFirestore.instance.collection('Usuaris');
      final userQuery = await userCollection.doc(firebaseUser!.uid).get();

      Map<String, dynamic> data = userQuery.data() as Map<String, dynamic>;

      UserProfile userProfile = UserProfile(
          username: data['username'],
          email: data['email'],
          name: data['name'],
          surname: data['surname'],
          numDogs: data['numDogs'],
          gossera: data['gossera'],
          premium: data['premium'],
          city: data['city'],
          profilePhotoUrl: data['PhotoURL'],
          additionalInfo: data['additionalInfo']);

      // Es va al la vista del perfil de l'usuari
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Mainpage(user: userProfile,)),
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
      appBar: AppBar(
        title: Text(''),
      ),
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


              SizedBox(height: 16),

              // Text Field de contrasenya
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

              SizedBox(height: 5),

              // Recuperar contrasenya
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return RecuperarContrasenyaScreen();
                        },),);
                      },
                        child:
                        Text(
                          "Has oblidat la teva contrasenya?",
                          style: TextStyle(color: Colors.blue),
                        )
                    ),
                  ],
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
