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

  User getUser(String mail, String password){
    User user;
    // XAVIII RECUPEREM USER
    user= User(city: 'Barcelona', username: 'oliviar' , email: mail, name: 'Olivia' , surname: 'Rodrigo', gossera: false, numDogs: 0, premium: false, additionalInfo: '');
    return user;
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // XAVI! VALIDAR AQUÍ INICI DE SESSIO
      User user = getUser(_emailController.text, _passwordController.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfileScreen(
            user: user
          ),
        ),
      );
    }
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
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Correo Electrónico'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce tu correo electrónico';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce tu contraseña';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
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
