import 'package:bark_and_meet/confirmation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'NewAccountScreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _termsAccepted = false;
  String? _errorMessage;

  UserProfile newAccount(String username, String mail, String password) {
    UserProfile user;
    user = UserProfile(
        city: 'Barcelona',
        username: username,
        email: mail,
        name: 'Olivia',
        surname: 'Rodrigo',
        profilePhotoUrl: "",
        gossera: false,
        numDogs: 0,
        premium: false,
        additionalInfo: '');
    return user;
  }




  Future<void> _register(BuildContext context) async {

    setState(() {
      _errorMessage = null;
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (!validateTerms()) {
      setState(() {
        _errorMessage =
            "Si us plau, accepta els termes de condicions i política de privacitat";
      });

      return;
    }

    if (password != confirmPassword) {
      // verificar contra
      setState(() {
        _errorMessage = "Les contrasenyes no coincideixen";
      });
      return;
    }

    if (!validatePassword(password)) {
      setState(() {
        _errorMessage =
            "La contrasenya ha de tenir com a mínim una majúscula, una minúscula i un número";
      });
      print("AAAA");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Es va al la vista de crear el perfil
      UserProfile newUser = UserProfile.basic(email: email);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewAccountScreen(user: newUser)),
      );
    } on FirebaseAuthException catch (error) {
      // Controlar errors.

      // Si hi ha un error, s'assigna un valor a _errorMessage perquè surti a la pantalla
      setState(() {
        switch (error.code) {
          case "email-already-in-use":
            _errorMessage = "La direcció de correu electrònic ja està registrada.";
            break;
          case "invalid-email":
            _errorMessage = "El format del correu electrònic és erroni.";
            break;
        }
      });

      // S'imprimeix l'error a la consola
      print("Error a l'iniciar sessió: $error");
    }
  }

  bool validatePassword(String password) {
    // Verificar la longitud mínima de la contrasenya
    if (password.length < 8) {
      return false;
    }

    // Verificar si hi ha com a mínim una majúscula, una minúscula i un número
    bool hasUppercase = false;
    bool hasLowercase = false;
    bool hasDigit = false;

    for (int i = 0; i < password.length; i++) {
      if (password[i].toUpperCase() == password[i]) {
        hasUppercase = true;
      }
      if (password[i].toLowerCase() == password[i]) {
        hasLowercase = true;
      }
      if (RegExp(r'\d').hasMatch(password[i])) {
        hasDigit = true;
      }
    }

    // La contrasenya ha de tenir com a mínim una majúscula, una minúscula i un número
    return hasUppercase && hasLowercase && hasDigit;
  }

  // es crida aquest mètode per alliberar recursos de memòria quan no s'utilitzen.
  // en aquest cas es llibera la memòria dels controladors del correu i contrasenya
  @override
  void dispose() {

    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool validateTerms() {
    return _termsAccepted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 48),
              Text(
                'Registrar-se',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Comfortaa',
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 24),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Constrasenya',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirmar contrasenya',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _termsAccepted,
                    onChanged: (value) {
                      setState(() {
                        _termsAccepted = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      'By signing up, you agree to Photo’s Terms of Service and\nPrivacy Policy.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  onPressed: () => _register(context),
                  child: Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

